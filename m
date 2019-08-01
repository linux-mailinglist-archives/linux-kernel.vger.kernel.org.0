Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA987E5DE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 00:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732705AbfHAWmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 18:42:52 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34352 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbfHAWmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 18:42:52 -0400
Received: by mail-pl1-f194.google.com with SMTP id i2so32843631plt.1;
        Thu, 01 Aug 2019 15:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fomdWM13prZfQ7vSZjiuPyioG/SgkiDt0SZpZ1hksfA=;
        b=Ee16V7TyWma9ZzO+MfYbY01TWD+PJYsqu/sciLstLnhHA0GZKS0yflmkj0vw3mciM+
         oRzxwP/T9fdmCduKRBSdymmttk0eOso7x+vDnZ7nwplyFrjHk5Uxhid68nQOMREFtu4I
         6QtnzS02SldThmbP4SySSEq9MDMC2raoyF2ChOKFd+ZvgBv+KEt7JnLqJI8esWwHpj6X
         uCFSjPkkDK6DRFKdgmUMPJmDPjRhtpRcSFGqXR+rS1zejPksAXh29y/7X0UeU98krnhP
         sdTynsvRO+pDSLqZAw7Z+f0nH4jdV6VDu99+lw7g0w8ZEMuuEQ/LMkEr6ZXZvxLyWSYh
         jtnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fomdWM13prZfQ7vSZjiuPyioG/SgkiDt0SZpZ1hksfA=;
        b=bkETA5A5OO1sabbdCiaQYTafIr5fww6W/IJ6CCp+jE1HPK/Pl56sm/DwSWMVajoRPr
         l5iZGUEvj9KtNBfNMsj791kex5fqBgsyAnhXlvi/NP1rsWg/YJRK/dCRCp9TQ1BcFdpo
         G1QcmMTEWu5jsXe0on1MpxKF4nvhDKX1bu59M47p/ZZF/GGYVxyp04qbtzzoVRf450An
         F3WLTcBMH2CsVbGc8kevNecJ/SMnnPW/p0sUl9iAEuN0OaVPZ/dUoZ01x7xvwPDkIq7M
         NZ7SMCWvpwZKr8nvT3qPvBWHgZuq2a3TNw+ZJKVObHUCYHrKvDgGx+oSSyyioPqiulpW
         g/+A==
X-Gm-Message-State: APjAAAVaEVWMCDFkdrTqCALVT3CrtLLur3wQ8ScFPyQ0AV62ASmoGvbt
        Rate39H2hNHEfcIxacp4Kkr2cUNeA0zrxv3/TXecj3S1
X-Google-Smtp-Source: APXvYqymyfyz8/HNnj11yxmLGdBA4kOlsce5EmA7gV+DlPXeUby884J8R66Q3PaDByYFW0yTPM5bHW8972cOoq9vkUg=
X-Received: by 2002:a17:902:2a29:: with SMTP id i38mr129344380plb.46.1564699371026;
 Thu, 01 Aug 2019 15:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190802075453.06066be1@canb.auug.org.au>
In-Reply-To: <20190802075453.06066be1@canb.auug.org.au>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 1 Aug 2019 17:42:36 -0500
Message-ID: <CAH2r5muO8rYmSEDHogiDkoWbMMm4bd367U-jzbpk_gixk7hkhg@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the cifs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed

On Thu, Aug 1, 2019 at 4:55 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Commit
>
>   c3ab166ec798 ("SMB3: Kernel oops mounting a encryptData share with CONFIG_DEBUG_VIRTUAL")
>
> is missing a Signed-off-by from its committer.
>
> --
> Cheers,
> Stephen Rothwell



-- 
Thanks,

Steve
