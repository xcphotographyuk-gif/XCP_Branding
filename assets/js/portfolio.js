const GALLERY_EL = document.getElementById('gallery');
const LIGHTBOX = document.getElementById('lightbox');
const LBPIC = document.getElementById('lightbox-picture');
const LBTITLE = document.getElementById('lightbox-title');
const LBDESC = document.getElementById('lightbox-desc');
const LBLINK = document.getElementById('lightbox-link');
const LBCLOSE = document.querySelector('.lightbox-close');
let projects = [];

function createCard(p){
  const card = document.createElement('div');
  card.className = 'card';
  const btn = document.createElement('button');
  btn.setAttribute('aria-label', p.title + ' — open');

  const picture = document.createElement('picture');
  const webp = document.createElement('source');
  webp.type = 'image/webp';
  webp.srcset = p.srcset ? p.srcset.map(s => s.replace(/\.jpg/g, '.webp')).join(', ') : p.imageWebp;
  const img = document.createElement('img');
  img.loading = 'lazy';
  img.alt = p.alt || p.title;
  img.src = p.image;
  if(p.srcset) img.srcset = p.srcset.join(', ');
  picture.appendChild(webp);
  picture.appendChild(img);

  const cap = document.createElement('div');
  cap.className = 'caption';
  cap.textContent = p.title + ' • ' + p.category;

  btn.appendChild(picture);
  btn.appendChild(cap);
  btn.addEventListener('click', ()=> openLightbox(p));
  card.appendChild(btn);
  return card;
}

function renderGallery(list){
  projects = list;
  GALLERY_EL.innerHTML = '';
  list.forEach(p => GALLERY_EL.appendChild(createCard(p)));
}

function openLightbox(p){
  LBPIC.innerHTML = '';
  const webp = document.createElement('source');
  webp.type = 'image/webp';
  webp.srcset = p.srcset ? p.srcset.map(s => s.replace(/\.jpg/g, '.webp')).join(', ') : (p.imageWebp || p.image);
  const img = document.createElement('img');
  img.src = p.image;
  img.alt = p.alt || p.title;
  if(p.srcset) img.srcset = p.srcset.join(', ');
  LBPIC.appendChild(webp);
  LBPIC.appendChild(img);
  LBTITLE.textContent = p.title + ' (' + p.year + ')';
  LBDESC.textContent = p.description || '';
  LBLINK.href = p.projectUrl || '#';
  LIGHTBOX.setAttribute('aria-hidden','false');
  document.body.style.overflow = 'hidden';
  LBCLOSE.focus();
}

function closeLightbox(){
  LIGHTBOX.setAttribute('aria-hidden','true');
  document.body.style.overflow = '';
}

LBCLOSE.addEventListener('click', closeLightbox);
LIGHTBOX.addEventListener('click', (e)=>{ if(e.target === LIGHTBOX) closeLightbox(); });
window.addEventListener('keydown',(e)=>{ if(e.key === 'Escape' && LIGHTBOX.getAttribute('aria-hidden') === 'false') closeLightbox(); });

fetch('/data/projects.json').then(r=>r.json()).then(renderGallery).catch(err=>{ console.error('Failed to load gallery data',err); GALLERY_EL.innerHTML = '<p>Failed to load portfolio data.</p>' });
