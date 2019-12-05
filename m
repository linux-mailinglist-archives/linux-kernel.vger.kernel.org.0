Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEAC2114896
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 22:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbfLEVTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 16:19:35 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42780 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbfLEVTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 16:19:34 -0500
Received: by mail-lf1-f67.google.com with SMTP id y19so3577876lfl.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 13:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p/5DUiJNUvTvn0ngWEENA6E5/rRQQAGsoL0gXtjWTaE=;
        b=RBRuYauI47ubpHmTcCCApQyzGgJHEh2S0LTdKqjeDtcwDoQ3f42FSm0NGn3QOkrjmx
         BTAMzCY4AzuZtb+azMbdOGZfG5SbecMEbid/TrFo6CC2Gwj6JBLKgZAeHLtdmva91Zw5
         +9JbkxvgQKwJjpu/8vep7+gvTbeGBnohVAe+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p/5DUiJNUvTvn0ngWEENA6E5/rRQQAGsoL0gXtjWTaE=;
        b=IWCiHILt/RamPciOkId36kedt+yCPzbtcWAji3lx/U3/isjYt0iaxKbs2ggyPW8iNx
         9PjQDBt8XS2w+uqz7dhQMcHB/UM4erKTnUZrCIZ1ab/OuJBlBjkYH+/Eoh62/TdGRKkG
         7DgAmWg3mjGR6RIUldGJnvrB52y4CpM3CzrSnDbpWWKq+qkBSi713AmvjB4P2WNXZ56b
         2P7/fMYl+pLigO+sGVw35l7wO/yB1cUDGOD0QZb7spZ/Hjapd6CfKi9yFZgSXz2pbiF5
         YP01T/HhD3WWkF0tCOXHMrM3SGqSAfLGQJoIGeH2wn+nC8Lm/0fF4drpY/7bfrLih7nl
         YlMA==
X-Gm-Message-State: APjAAAVNWecIJrcBZqvaBTT+whJCfeqAbZCd1kjXwM0RbizKcSHG3s/5
        9l+7eNc6QHVbm/Ax9oDN4/GOt48ihTo=
X-Google-Smtp-Source: APXvYqzSj3hOSli6pqmKW4zoICt9aq4vlgk4ogUDIQMz1D0e2HUmGVM1Y7SMiDqylSO3a5pl+17Q9A==
X-Received: by 2002:a05:6512:209:: with SMTP id a9mr6382362lfo.157.1575580772435;
        Thu, 05 Dec 2019 13:19:32 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id o69sm5514667lff.14.2019.12.05.13.19.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 13:19:31 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id l18so3629568lfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 13:19:30 -0800 (PST)
X-Received: by 2002:a05:6512:1dd:: with SMTP id f29mr2419467lfp.106.1575580770512;
 Thu, 05 Dec 2019 13:19:30 -0800 (PST)
MIME-Version: 1.0
References: <20191204200307.21047-1-idryomov@gmail.com>
In-Reply-To: <20191204200307.21047-1-idryomov@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Dec 2019 13:19:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjm+9rJvh=aRahfoN7z6waV87Eqr=-i_Cb7zOwHrugf5A@mail.gmail.com>
Message-ID: <CAHk-=wjm+9rJvh=aRahfoN7z6waV87Eqr=-i_Cb7zOwHrugf5A@mail.gmail.com>
Subject: Re: [GIT PULL] Ceph updates for 5.5-rc1
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 4, 2019 at 12:02 PM Ilya Dryomov <idryomov@gmail.com> wrote:
>
> Colin Ian King (1):
>       rbd: fix spelling mistake "requeueing" -> "requeuing"

Hmm. Why? That's not a spelling mistake, it's the same word.

Arguably "requeue" isn't much of a real word to begin with, and is
more of a made-up tech language. And then on wiktionary apparently the
only "ing" form you find is the one without the final "e", but
honestly, that's reaching. The word doesn't exist in _real_
dictionaries at all.

I suspect "re-queueing" with the explicit hyphen would be the more
legible spelling (with or without the "e" - both forms are as
correct), but whatever.

I've pulled it, but I really don't think it was misspelled to begin
with, and somebody who actually cares about language probably wouldn't
like either form.

              Linus
