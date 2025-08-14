/* ===== modal.js (lite) ===== */
(function () {
    // 공용 DOM 생성기
    function ensure(id, withCancel) {
        let el = document.getElementById(id);
        if (el) return el;
        el = document.createElement('div');
        el.id = id;
        el.className = 'modal';
        el.innerHTML = `
      <div class="modal__box" role="dialog" aria-modal="true">
        <h3 class="modal__title">${withCancel ? '확인' : '알림'}</h3>
        <p class="modal__msg"></p>
        <div class="modal__actions">
          ${withCancel ? '<button class="btn btn--ghost" data-cancel>취소</button>' : ''}
          <button class="btn" data-ok>확인</button>
        </div>
      </div>`;
        document.body.appendChild(el);
        return el;
    }

    function open(el) {
        el.classList.add('show');
        document.body.classList.add('modal-open');
    }
    function close(el) {
        el.classList.remove('show');
        document.body.classList.remove('modal-open');
    }

    // 알림 모달
    window.showModal = function (message, onOk) {
        const el = ensure('appModal', false);
        el.querySelector('.modal__msg').textContent = message || '';
        open(el);
        el.querySelector('[data-ok]').onclick = () => { close(el); onOk && onOk(); };
    };

    // 확인 모달
    window.confirmModal = function (message, onOk, onCancel) {
        const el = ensure('confirmModal', true);
        el.querySelector('.modal__msg').textContent = message || '';
        open(el);
        el.querySelector('[data-ok]').onclick = () => { close(el); onOk && onOk(); };
        el.querySelector('[data-cancel]').onclick = () => { close(el); onCancel && onCancel(); };
    };

    // ESC로 닫기
    document.addEventListener('keydown', e => {
        if (e.key !== 'Escape') return;
        ['appModal','confirmModal'].forEach(id => {
            const el = document.getElementById(id);
            if (el && el.classList.contains('show')) close(el);
        });
    });
})();
