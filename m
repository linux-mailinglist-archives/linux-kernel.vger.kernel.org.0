Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C42D10DB7C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2019 23:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfK2Way (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Nov 2019 17:30:54 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38098 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbfK2Way (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 17:30:54 -0500
Received: by mail-ot1-f65.google.com with SMTP id z25so26007947oti.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 14:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D72+9IYFK+2UGpLOMKnUsAdFdN1oVIrCuWqNswzdn3I=;
        b=LeGYFve/WDOGXwLMOhO6fpM95dtNQqRNSXnHJmkRVu7iO8X14h/3pHr6dozh/i7+kR
         q7Rpk6dxsi2zha/G6sB3cZuCWipU3PBjidxEizIgBtlgj1ctasqwDG/qedbIBmT2G1ea
         e+WBZ1mvfsv1EWDObLw5tsY/PS7dBKTsxgwjp3PiQLdEQ5+Uw9BQFmbmKonii6LgHjUT
         J7lMyXnTowzV1OAR93ayxbBP/Ci/f3QBlRq8A49817IKIjl6KvhbwpXtAkZsi4YNVv5r
         Wy00Eh1ur6kgT2S+Eco7DVZ1Rc3/K98pplcMjc4Jh4+/BQTdvrGviOywGfShphSkjf5s
         ZonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D72+9IYFK+2UGpLOMKnUsAdFdN1oVIrCuWqNswzdn3I=;
        b=XnSzXA6wLHGVvB/ZrPWiwGNQvD2AgwuWaCs7hGfeut7zcplZWoHPT/ZLNEjciriqSa
         TG6AUHmADyW7DeN/lkNXblk3Mh8Anlkel2Cc3fZ+7NFj3OO9Dvrh0OZmJadEIHB7u2vC
         wkOGM4asnDXhWm00RJ7yzNwNuUvbU8c/8/WzAxRUiJi7+pclt06cIIKZnsJGqT3tlBfy
         2EfvBi1bnUByTe62H0UKLUpZ0sIiAmHRn4oqqp3I8D2+mDr/gH2QDGcbu/GPXSAOHgup
         683B20U8WSqXMhvZyEQ2+3ONPRMqHEj6nT2d5d537+ZrTgAh5mA/X1NCHfRbu31OGroY
         w57g==
X-Gm-Message-State: APjAAAX+94Cbvm8OqdLPZD8OTZNmEVhM3f/wNObBNPiudog3uSYUwjXB
        qndK88Ticrj0hgYRbx3DAHzXvQ8ShC4MdmSv3ncorw==
X-Google-Smtp-Source: APXvYqwmfXI2+a3//4gwdKs0DYEgH2aNZnvLXvFqF8xNC9GT5Zlll0UM0+Y+bhD2pQdwXEtz1lEzdvPGp6zCYHeVpL8=
X-Received: by 2002:a9d:3b8:: with SMTP id f53mr9897247otf.180.1575066652615;
 Fri, 29 Nov 2019 14:30:52 -0800 (PST)
MIME-Version: 1.0
References: <254505c9-2b76-ebeb-306c-02aaf1704b88@kernel.dk>
 <CAG48ez33ewwQB26cag+HhjbgGfQCdOLt6CvfmV1A5daCJoXiZQ@mail.gmail.com>
 <1d3a458a-fa79-5e33-b5ce-b473122f6d1a@kernel.dk> <CAG48ez2VBS4bVJqdCU9cUhYePYCiUURvXZWneBx2KGkg3L9d4g@mail.gmail.com>
 <f4144a96-58ef-fba7-79f0-e5178147b6bb@rasmusvillemoes.dk> <CAG48ez1v5EmuSvn+LY8od_ZMt1QVdUWqi9DWLSp0CgMxkL=sNg@mail.gmail.com>
 <CAG48ez1FK6h4tEv=cGGtm84NXDkeiMV+woFmqQYPbcsOZjKxZw@mail.gmail.com>
In-Reply-To: <CAG48ez1FK6h4tEv=cGGtm84NXDkeiMV+woFmqQYPbcsOZjKxZw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 29 Nov 2019 23:30:26 +0100
Message-ID: <CAG48ez1y9vTOzUQCnMDJ1Wz22bTiuGyyjd6msNFVHSPQjj=CLg@mail.gmail.com>
Subject: Re: [PATCH RFC] signalfd: add support for SFD_TASK
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Jens Axboe <axboe@kernel.dk>, io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000543f87059883c8b6"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000543f87059883c8b6
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 28, 2019 at 8:18 PM Jann Horn <jannh@google.com> wrote:
> On Thu, Nov 28, 2019 at 11:07 AM Jann Horn <jannh@google.com> wrote:
> > On Thu, Nov 28, 2019 at 10:02 AM Rasmus Villemoes
> > <linux@rasmusvillemoes.dk> wrote:
> > > On 28/11/2019 00.27, Jann Horn wrote:
> > >
> > > > One more thing, though: We'll have to figure out some way to
> > > > invalidate the fd when the target goes through execve(), in particular
> > > > if it's a setuid execution. Otherwise we'll be able to just steal
> > > > signals that were intended for the other task, that's probably not
> > > > good.
> > > >
> > > > So we should:
> > > >  a) prevent using ->wait() on an old signalfd once the task has gone
> > > > through execve()
> > > >  b) kick off all existing waiters
> > > >  c) most importantly, prevent ->read() on an old signalfd once the
> > > > task has gone through execve()
> > > >
> > > > We probably want to avoid using the cred_guard_mutex here, since it is
> > > > quite broad and has some deadlocking issues; it might make sense to
> > > > put the update of ->self_exec_id in fs/exec.c under something like the
> > > > siglock,
> > >
> > > What prevents one from exec'ing a trivial helper 2^32-1 times before
> > > exec'ing into the victim binary?
> >
> > Uh, yeah... that thing should probably become 64 bits wide, too.
>
> Actually, that'd still be wrong even with the existing kernel code for
> two reasons:
>
>  - if you reparent to a subreaper, the existing exec_id comparison breaks
>  - the new check here is going to break if a non-leader thread goes
> through execve(), because of the weird magic where the thread going
> through execve steals the thread id (PID) of the leader
>
> I'm gone for the day, but will try to dust off the years-old patch for
> this that I have lying around somewhere tomorrow. I should probably
> send it through akpm's tree with cc stable, given that this is already
> kinda broken in existing releases...

I'm taking that back, given that I was wrong when writing this mail.
But I've attached the old patch, in case you want to reuse it. That
cpu-plus-64-bits scheme was Andy Lutomirski's idea.

If you use that, you'd have to take the cred_guard_mutex for ->poll
and ->read, but I guess that's probably fine for signalfd.

--000000000000543f87059883c8b6
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-exec-generate-unique-per-execution-per-process-ident.patch"
Content-Disposition: attachment; 
	filename="0001-exec-generate-unique-per-execution-per-process-ident.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k3kpyx460>
X-Attachment-Id: f_k3kpyx460

RnJvbSBhNmZjZmNjMTVkYWNhZWI0Y2MxMjBkZjQ0N2E3MTlkYTNiOWUwYzlkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYW5uIEhvcm4gPGphbm5oQGdvb2dsZS5jb20+CkRhdGU6IEZy
aSwgMjkgTm92IDIwMTkgMjM6MTA6MzMgKzAxMDAKU3ViamVjdDogW1BBVENIXSBleGVjOiBnZW5l
cmF0ZSB1bmlxdWUgcGVyLWV4ZWN1dGlvbiwgcGVyLXByb2Nlc3MgaWRlbnRpZmllcnMKClRoaXMg
YWRkcyBhIG1lbWJlciBwcml2dW5pdCAoInByaXZpbGVnZSB1bml0IikgdG8gdGFza19zdHJ1Y3Qu
CnByaXZ1bml0IGlzIG9ubHkgc2hhcmVkIGJ5IHRocmVhZHMgYW5kIGNoYW5nZXMgb24gZXhlY3Zl
KCkuCkl0IGNhbiBiZSB1c2VkIHRvIGNoZWNrIHdoZXRoZXIgdHdvIHRhc2tzIGFyZSB0ZW1wb3Jh
bGx5IGFuZCBzcGF0aWFsbHkKZXF1YWwgZm9yIHByaXZpbGVnZSBjaGVja2luZyBwdXJwb3Nlcy4K
ClRoZSBpbXBsZW1lbnRhdGlvbiBvZiBsb2NhbGx5IHVuaXF1ZSBJRHMgaXMgaW4gc2NoZWQuaCBh
bmQgZXhlYy5jIGZvciBub3cKYmVjYXVzZSB0aG9zZSBhcmUgdGhlIG9ubHkgdXNlcnMgc28gZmFy
IC0gaWYgYW55dGhpbmcgZWxzZSB3YW50cyB0byB1c2UKdGhlbSBpbiB0aGUgZnV0dXJlLCB0aGV5
IGNhbiBiZSBtb3ZlZCBlbHNld2hlcmUuCgpTaWduZWQtb2ZmLWJ5OiBKYW5uIEhvcm4gPGphbm5o
QGdvb2dsZS5jb20+Ci0tLQogZnMvZXhlYy5jICAgICAgICAgICAgIHwgMTcgKysrKysrKysrKysr
KysrKysKIGluY2x1ZGUvbGludXgvc2NoZWQuaCB8IDE0ICsrKysrKysrKysrKysrCiBrZXJuZWwv
Zm9yay5jICAgICAgICAgfCAgMSArCiAzIGZpbGVzIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS9mcy9leGVjLmMgYi9mcy9leGVjLmMKaW5kZXggYzI3MjMxMjM0NzY0Li40
Y2VhOGFjYjk1ZTUgMTAwNjQ0Ci0tLSBhL2ZzL2V4ZWMuYworKysgYi9mcy9leGVjLmMKQEAgLTEz
MzEsNiArMTMzMSwyMiBAQCB2b2lkIHdvdWxkX2R1bXAoc3RydWN0IGxpbnV4X2JpbnBybSAqYnBy
bSwgc3RydWN0IGZpbGUgKmZpbGUpCiB9CiBFWFBPUlRfU1lNQk9MKHdvdWxkX2R1bXApOwogCisv
KiB2YWx1ZSAwIGlzIHJlc2VydmVkIGZvciBpbml0ICovCitzdGF0aWMgREVGSU5FX1BFUl9DUFUo
dTY0LCBsdWlkX2NvdW50ZXJzKSA9IDE7CisKKy8qCisgKiBBbGxvY2F0ZXMgYSBuZXcgTFVJRCBh
bmQgd3JpdGVzIHRoZSBhbGxvY2F0ZWQgTFVJRCB0byBAb3V0LgorICogVGhpcyBmdW5jdGlvbiBt
dXN0IG5vdCBiZSBjYWxsZWQgZnJvbSBJUlEgY29udGV4dC4KKyAqLwordm9pZCBhbGxvY19sdWlk
KHN0cnVjdCBsdWlkICpvdXQpCit7CisJcHJlZW1wdF9kaXNhYmxlKCk7CisJb3V0LT5jb3VudCA9
IHJhd19jcHVfcmVhZChsdWlkX2NvdW50ZXJzKTsKKwlyYXdfY3B1X2FkZChsdWlkX2NvdW50ZXJz
LCAxKTsKKwlvdXQtPmNwdSA9IHNtcF9wcm9jZXNzb3JfaWQoKTsKKwlwcmVlbXB0X2VuYWJsZSgp
OworfQorCiB2b2lkIHNldHVwX25ld19leGVjKHN0cnVjdCBsaW51eF9iaW5wcm0gKiBicHJtKQog
ewogCS8qCkBAIC0xMzg0LDYgKzE0MDAsNyBAQCB2b2lkIHNldHVwX25ld19leGVjKHN0cnVjdCBs
aW51eF9iaW5wcm0gKiBicHJtKQogCS8qIEFuIGV4ZWMgY2hhbmdlcyBvdXIgZG9tYWluLiBXZSBh
cmUgbm8gbG9uZ2VyIHBhcnQgb2YgdGhlIHRocmVhZAogCSAgIGdyb3VwICovCiAJY3VycmVudC0+
c2VsZl9leGVjX2lkKys7CisJYWxsb2NfbHVpZCgmY3VycmVudC0+cHJpdnVuaXQpOwogCWZsdXNo
X3NpZ25hbF9oYW5kbGVycyhjdXJyZW50LCAwKTsKIH0KIEVYUE9SVF9TWU1CT0woc2V0dXBfbmV3
X2V4ZWMpOwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zY2hlZC5oIGIvaW5jbHVkZS9saW51
eC9zY2hlZC5oCmluZGV4IDA3ZTY4ZDlmNWRjNC4uNmEzYzE2YjNiNDNkIDEwMDY0NAotLS0gYS9p
bmNsdWRlL2xpbnV4L3NjaGVkLmgKKysrIGIvaW5jbHVkZS9saW51eC9zY2hlZC5oCkBAIC02MjYs
NiArNjI2LDE5IEBAIHN0cnVjdCB3YWtlX3Ffbm9kZSB7CiAJc3RydWN0IHdha2VfcV9ub2RlICpu
ZXh0OwogfTsKIAorLyogbG9jYWxseSB1bmlxdWUgSUQgKi8KK3N0cnVjdCBsdWlkIHsKKwl1NjQg
Y291bnQ7CisJdW5zaWduZWQgaW50IGNwdTsKK307CisKK3ZvaWQgYWxsb2NfbHVpZChzdHJ1Y3Qg
bHVpZCAqb3V0KTsKKworc3RhdGljIGlubGluZSBib29sIGx1aWRfZXEoY29uc3Qgc3RydWN0IGx1
aWQgKmEsIGNvbnN0IHN0cnVjdCBsdWlkICpiKQoreworCXJldHVybiBhLT5jb3VudCA9PSBiLT5j
b3VudCAmJiBhLT5jcHUgPT0gYi0+Y3B1OworfQorCiBzdHJ1Y3QgdGFza19zdHJ1Y3QgewogI2lm
ZGVmIENPTkZJR19USFJFQURfSU5GT19JTl9UQVNLCiAJLyoKQEAgLTk0MSw2ICs5NTQsNyBAQCBz
dHJ1Y3QgdGFza19zdHJ1Y3QgewogCS8qIFRocmVhZCBncm91cCB0cmFja2luZzogKi8KIAl1MzIJ
CQkJcGFyZW50X2V4ZWNfaWQ7CiAJdTMyCQkJCXNlbGZfZXhlY19pZDsKKwlzdHJ1Y3QgbHVpZAkJ
CXByaXZ1bml0OwogCiAJLyogUHJvdGVjdGlvbiBhZ2FpbnN0IChkZS0pYWxsb2NhdGlvbjogbW0s
IGZpbGVzLCBmcywgdHR5LCBrZXlyaW5ncywgbWVtc19hbGxvd2VkLCBtZW1wb2xpY3k6ICovCiAJ
c3BpbmxvY2tfdAkJCWFsbG9jX2xvY2s7CmRpZmYgLS1naXQgYS9rZXJuZWwvZm9yay5jIGIva2Vy
bmVsL2ZvcmsuYwppbmRleCAwMGI2NGY0MWMyYjQuLjc1Nzg0ZmY5YzlmMiAxMDA2NDQKLS0tIGEv
a2VybmVsL2ZvcmsuYworKysgYi9rZXJuZWwvZm9yay5jCkBAIC0yMTUyLDYgKzIxNTIsNyBAQCBz
dGF0aWMgX19sYXRlbnRfZW50cm9weSBzdHJ1Y3QgdGFza19zdHJ1Y3QgKmNvcHlfcHJvY2VzcygK
IAkJCXAtPmV4aXRfc2lnbmFsID0gYXJncy0+ZXhpdF9zaWduYWw7CiAJCXAtPmdyb3VwX2xlYWRl
ciA9IHA7CiAJCXAtPnRnaWQgPSBwLT5waWQ7CisJCWFsbG9jX2x1aWQoJnAtPnByaXZ1bml0KTsK
IAl9CiAKIAlwLT5ucl9kaXJ0aWVkID0gMDsKLS0gCjIuMjQuMC4zOTMuZzM0ZGMzNDhlYWYtZ29v
ZwoK
--000000000000543f87059883c8b6--
