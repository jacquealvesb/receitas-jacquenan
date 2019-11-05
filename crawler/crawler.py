import requests
from bs4 import BeautifulSoup as bs
from flask import Flask, request

# Starts flask app
app = Flask(__name__)

def parse(html):
	'''Parse the html to retrieve ingredients and instructions
	
	Arguments:
		html {String} -- a giant string of the page source
	'''

	soup = bs(html, 'lxml')

	# Gets ingredients
	ingredients = []
	ingredients = list(map(lambda x: x.text, soup.find_all(class_='p-ingredient')))
	
	# Gets instructions sorted
	instructions = []
	instructions = list(map(lambda x: x.text, soup.find(class_='e-instructions').find_all('p')))
	
	# Gets video thumbnail
	img = 'https:' + soup.find(class_='Video__Thumbnail-sc-14lx47x-1')['src']
	
	return (ingredients, instructions, img)

@app.route('/recipe')
def getRecipe():
	'''Requests the url and parse the recipe
	the recipes is passed through '?recipe=' on the url calling
	
	Return:
		result {Dictionary} -- json with ingredients, instructions and image
	'''

	recipe = request.args.get('recipe')
	
	try:
		req = requests.get(recipe)
		(ingredients, instructions, thumbnail) = parse(req.content)
		
		return {
		'ingredients': ingredients,
		'instructions': instructions,
		'thumbnail': thumbnail
		}
	except requests.exceptions.URLRequired as exception:
		raise(exception)

@app.route('/hamburguer')
def oi():
	return 'oi'

if __name__ == '__main__':
	app.run()



