Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 827C6194FBF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 04:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbgC0Dml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 23:42:41 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34980 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgC0Dml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 23:42:41 -0400
Received: by mail-lj1-f195.google.com with SMTP id k21so8795955ljh.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 20:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HIuSTObh7u09sifP9kfA0TVRhLTjLKAawBNoUe2zMHE=;
        b=chenvtZL+Yxk5qS9Zfu5Vwb+nwNV5m1yqdKYF1CAdtQATbaS1Ct73A1/uBf8JlrXoi
         JAqlbyc6kaqstdZVVtvXHAjCrbSLKYFO2D0lKo6netGufJ7fJ918bK08oGZC6ZhVq42V
         bSwCF/SxhsBKLoOkSbaVx+Qaly0e452BSugwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HIuSTObh7u09sifP9kfA0TVRhLTjLKAawBNoUe2zMHE=;
        b=Msa3/4pvtcFQIbfyQByzq3kDBVSwpRJ9B6vHIkuVxKCFhZyCJVMBZhSlB98X74O5Ss
         KbDc0/rB5T2RqBPxFkQno9Xj85Tb03O+SIm+MihxaLkrw101BtBNNXcfSMD3YIXALkzx
         m0z7QFm4oS6HFHM6NfdMp3jVCBj1blgcRZUTjpeS7SXncT1V3hWDTIZiDFEHUulic6nM
         YIvJiqaDe3L1hrXTEjbTMTM8mzhmMOliKTdZgpZFX8q0dfnacvLkyxLF9YIvYVntJ/rO
         MUuzgrvWFILfTopuYGd1huQ+UIGFVyYsbMHYemDlhBYRxyGW+2MduaNoxBmLTm8wxt3n
         AeDw==
X-Gm-Message-State: AGi0Pubkh15n159Eew7jdRDDcOaPQKZIiKVmGPfaZVtZFpOYj9KGYhFy
        ati1UM1jlRbH7CvK1umSqaaaJkq/w2M=
X-Google-Smtp-Source: APiQypJGW1CI8WCdoKb1HD/8wQHi0MMyiMZEQea4JwwZaF21rAXdplB/QV4uAIU5LkiElKnfu7ntZA==
X-Received: by 2002:a2e:9681:: with SMTP id q1mr7574804lji.179.1585280558622;
        Thu, 26 Mar 2020 20:42:38 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id q10sm2404406lfa.29.2020.03.26.20.42.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 20:42:37 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id n17so8769572lji.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 20:42:37 -0700 (PDT)
X-Received: by 2002:a2e:7c1a:: with SMTP id x26mr5825891ljc.209.1585280557026;
 Thu, 26 Mar 2020 20:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200323185057.GE23230@ZenIV.linux.org.uk> <20200323185127.252501-1-viro@ZenIV.linux.org.uk>
 <20200323185127.252501-5-viro@ZenIV.linux.org.uk> <CAHk-=wgMmmnQTFT7U9+q2BsyV6Ge+LAnnhPmv0SUtFBV1D4tVw@mail.gmail.com>
 <20200324020846.GG23230@ZenIV.linux.org.uk> <CAHk-=whTwaUZZ5Aj_Viapf2tdvcd65WdM4jjXJ3tdOTDmgkW0g@mail.gmail.com>
 <20200324204246.GH23230@ZenIV.linux.org.uk> <CAHk-=whnTRF5yA2MrPGcmMm=hXaGHfC2HEDtNzA=_1=szhJ4-w@mail.gmail.com>
 <20200327024227.GT23230@ZenIV.linux.org.uk>
In-Reply-To: <20200327024227.GT23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 26 Mar 2020 20:42:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjn9Ohb7TW3OxaS0MTURi=boXzk=0Lo0WT-pN2CPE9PzA@mail.gmail.com>
Message-ID: <CAHk-=wjn9Ohb7TW3OxaS0MTURi=boXzk=0Lo0WT-pN2CPE9PzA@mail.gmail.com>
Subject: Re: [RFC][PATCH 5/7] x86: convert arch_futex_atomic_op_inuser() to user_access_begin/user_access_end()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Your threads are really hard to follow when you reply to an email in
the middle of the previous series and make that reply be the cover
letter for the next one.

Anyway, apart from the problem with the futex series that I replied
to, I don't see anything wrong.

I will not boot with both series applied in a test-tree.

Wish me luck.

           Linus
