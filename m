Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C852618C071
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 20:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgCSTeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 15:34:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48696 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbgCSTeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 15:34:09 -0400
Received: from mail-lf1-f71.google.com ([209.85.167.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1jF0vf-0006y0-SU
        for linux-kernel@vger.kernel.org; Thu, 19 Mar 2020 19:34:07 +0000
Received: by mail-lf1-f71.google.com with SMTP id o25so1268120lfb.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 12:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8PARSOIOUIl7HEjmOfNmM9qE7MvdCt1w1qAJWcg9LIE=;
        b=MLWa1XiOQ74wMDfkpvHIHGb4/tgO6MecSDW8erYcdmKRVY3jK9rITFsVUp3vbpjfvP
         eXn18YCqdMQwKn88+jxkwrz5u5KGYCukAYcBgZQOhKxCTId94y400BG7pwNRpeVPaqBj
         2fw0JnBCPk2WOQ7kZbtpbMYhJlt6MEvieDMB6ISs0opiyn5N+a5U2xK29oQ+zXtNRkni
         rpnNonmC2VLDqZR7rM1bcpm90vWWkDVsSLjGvCQ2Bo3oAAAMoGfo3MtXGOcBMbuTihyY
         WuRVD3Yu0vJnr1g+WxV4PXDqMxU8eBe9bjWwdAxHgqSrOthKaLrdpT1S5kjSMlAI/QSh
         CQeg==
X-Gm-Message-State: ANhLgQ3E4Ov9sz++5N8q8Dmq7zBKwIo1h12vuZQ25L9PYksC9zIJOcKo
        63pMGmG3c/mdVswYKbolJek+F28O2HnQH4mDalfIAs9hTdNsPpyTF3U2rIX0aiz1x5zryqfTH/g
        vljrl+K/dSVRlPIJlq229s77zrH7faP9WhCP71GBQxdk579Xsb8Yr+rCPOQ==
X-Received: by 2002:a2e:b554:: with SMTP id a20mr3167553ljn.34.1584646446940;
        Thu, 19 Mar 2020 12:34:06 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtr0rgWYtmrsAVjHp2wMAPFGOg/3YVyK7C6KvTAKV9PEkHsojLpBsi7zau+NmzoaMU0ew+eRpuxvN9fwVZ01lA=
X-Received: by 2002:a2e:b554:: with SMTP id a20mr3167544ljn.34.1584646446768;
 Thu, 19 Mar 2020 12:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200319191806.11453-1-gpiccoli@canonical.com>
In-Reply-To: <20200319191806.11453-1-gpiccoli@canonical.com>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Thu, 19 Mar 2020 16:33:30 -0300
Message-ID: <CAHD1Q_zycuasUWz2TmrKLS47qQZaw2Gp1gcuW7vhdyYpkKkvyg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: Better document the softlockup_panic sysctl
To:     linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        swood@redhat.com, mcgrof@kernel.org,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This shows as it was sent by me, 15 minutes ago...I can't even imagine
what happened, I didn't resend that.
Sorry for the inconvenience!
Cheers,


Guilherme
