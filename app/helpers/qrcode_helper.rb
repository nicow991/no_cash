module QrcodeHelper
  def app_qr_code_url
    app_url = 'https://www.loopapp.co'
    qr_code = RQRCode::QRCode.new(app_url)
    # Get SVG data representing the QR code
    qr_code.as_svg.html_safe
  end
end
