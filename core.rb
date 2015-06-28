###################
# Import Csv to Overlay on Image
###################

require 'csv'
require 'rmagick'

include Magick


#simple method to take passed string and overlay
#on top of an image.
def makeImg2 (txt, outImg)


	img = Magick::Image.read('inherent.jpg').first

	#create text square (layer)
	drw = Magick::Draw.new
	drw.fill = 'white'
	drw.fill_opacity(0.65)
	drw.stroke = 'white'
	drw.stroke_opacity(0.65)
	drw.stroke_width(3)
	drw.stroke_linecap('round')
	drw.stroke_linejoin('round')
	drw.rectangle(75,265,325,340)
	drw.draw(img)
	
	#create text annotate
	text = Magick::Draw.new	
	text.annotate(img, 0,0,0,0, txt) {
		self.fill = "black"

		self.font_family = "arial"
		self.pointsize	=	18
		self.gravity = CenterGravity
	}	

	#text.draw(img)

	img.write 'output/'+outImg

end



#Main block of code
prime = 0
CSV.foreach('code.csv') do |row|
	if prime > 0
		
		puts row[0] + '.gif'
		makeImg2 row[0], row[0] + '.gif'

		prime = prime + 1
	else
		#skip first row
		prime = prime + 1
	end

end

