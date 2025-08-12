// ===== modal.js (최종) =====

// 공용 알림 모달
window.showModal = function (message, onOk) {
    const ov = document.getElementById('appModal');
    if (!ov) { console.warn('[modal] #appModal not found'); return alert(message); }
    ov.querySelector('.modal-message').textContent = message || '';
    ov.classList.add('show');                // .show 사용
    if (getComputedStyle(ov).display === 'none') ov.style.display = 'flex'; // display 방식도 겸처리
    document.getElementById('modalOk').onclick = function () {
        ov.classList.remove('show');
        ov.style.display = 'none';
        if (typeof onOk === 'function') onOk();
    };
};

// 공용 확인 모달 (확인/취소)
window.confirmModal = function (message, onOk, onCancel) {
    const ov = document.getElementById('confirmModal');
    if (!ov) { console.warn('[modal] #confirmModal not found'); return; }
    ov.querySelector('.modal-message').textContent = message || '';
    ov.classList.add('show');
    if (getComputedStyle(ov).display === 'none') ov.style.display = 'flex';
    const ok = document.getElementById('confirmOk');
    const cancel = document.getElementById('confirmCancel');
    ok.onclick = function () { ov.classList.remove('show'); ov.style.display = 'none'; if (typeof onOk === 'function') onOk(); };
    cancel.onclick = function () { ov.classList.remove('show'); ov.style.display = 'none'; if (typeof onCancel === 'function') onCancel(); };
};

// (선택) 기본 alert 가로채기
// window.alert = function (msg) { showModal(String(msg)); };

// ESC로 닫기
document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape') {
        document.getElementById('appModal')?.classList.remove('show');
        document.getElementById('appModal')?.style && (document.getElementById('appModal').style.display = 'none');
        document.getElementById('confirmModal')?.classList.remove('show');
        document.getElementById('confirmModal')?.style && (document.getElementById('confirmModal').style.display = 'none');
    }
});

// ===== 폴백: 마크업이 없거나 modal.js만 단독으로 로드돼도 동작 보장 =====
(function ensureModal() {
    // 알림 모달 DOM 자동 생성
    if (!document.getElementById('appModal')) {
        const el = document.createElement('div');
        el.id = 'appModal';
        el.className = 'modal-overlay';
        el.style.display = 'none';
        el.innerHTML = `
      <div class="modal-box">
        <h3 class="modal-title">알림</h3>
        <p class="modal-message"></p>
        <div class="modal-actions" style="display:flex;justify-content:center;gap:10px;">
          <button type="button" id="modalOk" class="modal-btn">확인</button>
        </div>
      </div>`;
        document.body.appendChild(el);
    }

    // (옵션) 확인 모달 DOM 자동 생성
    if (!document.getElementById('confirmModal')) {
        const el = document.createElement('div');
        el.id = 'confirmModal';
        el.className = 'modal-overlay';
        el.style.display = 'none';
        el.innerHTML = `
      <div class="modal-box">
        <h3 class="modal-title">확인</h3>
        <p class="modal-message"></p>
        <div class="modal-actions" style="display:flex;justify-content:center;gap:10px;">
          <button type="button" id="confirmCancel" class="modal-btn cancel">취소</button>
          <button type="button" id="confirmOk" class="modal-btn">확인</button>
        </div>
      </div>`;
        document.body.appendChild(el);
    }

    // 가려짐 방지
    const zfix = document.createElement('style');
    zfix.textContent = `.modal-overlay{z-index:99999 !important}`;
    document.head.appendChild(zfix);
})();
