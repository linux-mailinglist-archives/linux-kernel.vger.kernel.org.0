Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 736D04F041
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 23:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfFUVEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 17:04:21 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35216 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfFUVEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 17:04:21 -0400
Received: by mail-io1-f68.google.com with SMTP id m24so728504ioo.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 14:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Fh/tHiLfHzglDRmRK4MeWaH9B+D3D43UNRCXEIZlio=;
        b=JQWyLEVmQVEgB6eNmuJNoqU10ZpR9B1hs/VTTtZMK1atm2V9pgcLici+O3eq8GoZ20
         PAwvAc7mTXhsw8s6ULWRqa1ygdEyl4fl4BZxysRViMT+5gnFJGU4xYVKNZy8Q9lWrYfQ
         +9Qno0D/zVZhrHTMhFEASp79IJzkBm+AjX1taO54zAkqcnJEkUO1OL21fDu/3pmLjRc8
         CgO/JOKOHH1ocaoPktWOY4ccOBky8fxp+OqkF0pJSfnAf5v6aC6nSJdcLIZRuCu1m9jY
         J574JWeZIuizTc+yJhlGXZeTOajB38zjhNjna9YhsaqAc+ox0ywjtwHq0Wq1jv8LWMGz
         rtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Fh/tHiLfHzglDRmRK4MeWaH9B+D3D43UNRCXEIZlio=;
        b=CcMiUWHFvB8UdTSJPZVoUPGYp/9EY76TtFGsKoSEeUM8pj8pKX9ZnpOFtCojmte8mc
         BbdOZqytlzuvVhe4NkEPaTSnxOYIETXNrAszP8mqBS4va2vK+V40dfzbgwejDRoe4+ag
         hHL0ZZP2wi2pgsiTpULHzxe94CDltAG/Py1loh4BKphsp/tyqFYOsAPRbNq4qoFmq+f5
         aK18+7C461wW0s/tSNygGkRXENxnP2s+d0vpSavzn05oLKo13mJjziSoYZiJKkIcImj8
         fLj+NKbrUZGecBP53n0jPYNalHSRwssPgW3CH4TGi98cudrA5tU3G0JllMeuN064GLGq
         OXFw==
X-Gm-Message-State: APjAAAU6gKc6Sn4TU4qpgz7DJmy3rAaQ+8tDhd+P1dhE/gkm6jnBIsFP
        fi2MjsdGXfC4FkOMfDG+da7FqQ/XrhCkH1x4ZXVy3w==
X-Google-Smtp-Source: APXvYqyxdCHKg+jO9Z3sbuqDNxn5VjTHJLVEcF2t+ZhmVfXWXM8SChGt9mnaivlj0TOlGOadCqPgUHEkI13I8bpCo80=
X-Received: by 2002:a02:ab99:: with SMTP id t25mr8680797jan.113.1561151059759;
 Fri, 21 Jun 2019 14:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
 <20190621011941.186255-4-matthewgarrett@google.com> <201906202028.5AB58C3@keescook>
 <CACdnJut_C_h2JjryDxEm9U_rpSJFkVyxq3iCW9=AhwcdVig=9g@mail.gmail.com>
In-Reply-To: <CACdnJut_C_h2JjryDxEm9U_rpSJFkVyxq3iCW9=AhwcdVig=9g@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Fri, 21 Jun 2019 14:04:08 -0700
Message-ID: <CACdnJutWhpgKeWWBv8AkTxBxoVempiuVRJzk7mrUF6LMmnwp4Q@mail.gmail.com>
Subject: Re: [PATCH V33 03/30] security: Add a static lockdown policy LSM
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 12:37 PM Matthew Garrett <mjg59@google.com> wrote:
> I'll check, I'm bad at finding these new fangled things.

Ah, I see - there's sysfs_match_string(), but that doesn't really work
for this case because we'd still need to do another set of checks to
see whether the level we get is in lockdown_levels, not just
lockdown_reasons.
