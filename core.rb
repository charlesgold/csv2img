###################
# Import Csv to Overlay on Image
###################

require 'csv'
require 'rmagick'

include Magick


def makeImg (txt, outImg)

	imgWidth	=	200
	imgHeight	=	400

	canvas = Magick::ImageList.new
	#canvas.new_image(imgWidth,imgHeight)
	canvas = Magick::ImageList.new("inherent.jpg")

	text = Magick::Draw.new
	
	text.annotate(canvas, 0,0,0,0, txt) {
		self.fill = "black"

		self.font_family = "arial"
		self.pointsize	=	25
		self.gravity = CenterGravity
	}	

	#create rectangle to have some bg
	text.rectangle(75, 35,0,0) {
		self.fill = 'white'	
		self.stroke = 'white'
	}
	text.draw(canvas)
	

	canvas.write(outImg)
	
end

def makeImg2 (txt, outImg)


	img = Magick::Image.read('inherent.jpg').first
	drw = Magick::Draw.new

	drw.fill = 'white'
	drw.fill_opacity(0.65)
	drw.stroke = 'white'
	drw.stroke_opacity(0.65)
	drw.stroke_width(3)
	drw.stroke_linecap('round')
	drw.stroke_linejoin('round')
	drw.rectangle(75,250,300,325)
	#drw.gravity = CenterGravity
	drw.draw(img)
	img.write outImg

end

CSV.foreach('code.csv') do |row|
	puts row[0] + '.gif'
	makeImg2 row[0], row[0] + '.gif'

end

