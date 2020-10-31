export default function(value, format) {
  let locale = typeof I18n !== 'undefined' ? I18n.locale : 'en'
  if (typeof value != 'object') value = new Date(value);
  let options = {weekday: 'short', month: 'short', day: '2-digit', hour: 'numeric', minute: '2-digit'}
  if (format == 'date') options = {weekday: 'long', month: 'long', day: '2-digit'}
  if (format == 'time') options = {hour: 'numeric', minute: '2-digit'}
  options.timeZone = 'Asia/Tokyo'
  return new Intl.DateTimeFormat(locale, options).format(value) 
}