Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9A1131C0F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 00:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgAFXFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 18:05:17 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42041 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgAFXFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 18:05:16 -0500
Received: by mail-lj1-f194.google.com with SMTP id y4so38318218ljj.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 15:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YUbyXuNj/nV2mvWyQuOWH4rMIzJEpHNGktDVq6OfmV4=;
        b=Y24G2rLT62gVi5UB4PSR0/0wz9F1EYqZ56Cd5xJQebRbp8KCL3GxnMuy9jCL3Yhfwf
         HjbIDLD3LDoKQm+F5/Rmtd4LjbGEwULoYlWfbBA6DHBJDjNPUDuyAycdA7FrP/nr/WrY
         lMSYjhOM+wrLU48osUO/7sLQVyCy8fevVa7H0pVciTJFeDg00Ft8UEIrQcCjT7R7J5gY
         AUbQt/I3jdZ+fV7E3Gq2u6vGW2f4LBkv/JnUXIO5eHav6EUS0vqIi80JL2JsM+1JU5H8
         gbVoNBgkYwEWkw82fR+oU0qyWJas3JeG1t0BkedS8F/NgbPggf/lQyiglaedmE/BvOeN
         pvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YUbyXuNj/nV2mvWyQuOWH4rMIzJEpHNGktDVq6OfmV4=;
        b=MYdEUSB/HUMVFiuuOJLFhN01qzuq4PSH51Le8WUBCeR3pIaaIMqkk9EXwVROSgZoo+
         5JBCUzGG+MLaJdasjL1wfrtW+T6O9A8j3p97GB1iSxfXonCRYtb7xeY3jWsAgPLNYjyB
         TqMrheML4pEBhMnZeopzuoppHOSPJcsX59be6PLeXTZ4Wfb7vQLwbSI3mWgT+T2yt4hZ
         682uHbuz/ximd21poj1l1Y0BKwowqKIZ7U47L0Ink4rrhdQOLnb3Z2QqzBQpLKNxyjVc
         WOfCbS1n1o+4OHVzRvbVS5vZxzaPmVOXWUXj3cQigUvR3KdC/DM5hVYclnOkZ3rt/8xt
         yhUQ==
X-Gm-Message-State: APjAAAXzXx0XjexP3LsfKKXDDaR3rWB1yTt8GpUxlB92AOCRh/Snlae7
        A3cnqs82sLKonVjCbaRCU5634A0OJr1wd0fnCyfoUQ==
X-Google-Smtp-Source: APXvYqzTTARViZbNA1PJIgCijb0mRSzkTPdGonONIBTiDvfmnoknOA5gNAB0/N4oSUa+0AujUlg0CqsTUQj0MWd+Yss=
X-Received: by 2002:a2e:844e:: with SMTP id u14mr62036735ljh.183.1578351913918;
 Mon, 06 Jan 2020 15:05:13 -0800 (PST)
MIME-Version: 1.0
References: <20191214114913.8610-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20191214114913.8610-1-lukas.bulwahn@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jan 2020 00:05:02 +0100
Message-ID: <CACRpkdaY6jCdSpdDejo87CgoO6qbekj-QO354a1K0BeHYOnCpw@mail.gmail.com>
Subject: Re: [PATCH] fmc: remove left-over ipmi-fru.h after fmc deletion
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Federico Vaga <federico.vaga@cern.ch>,
        Denis Efremov <efremov@linux.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pat Riehecky <riehecky@fnal.gov>,
        Alessandro Rubini <rubini@gnudd.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Sebastian Duda <sebastian.duda@fau.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 14, 2019 at 12:49 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Commit 6a80b30086b8 ("fmc: Delete the FMC subsystem") from Linus Walleij
> deleted the obsolete FMC subsystem, but missed the MAINTAINERS entry and
> include/linux/ipmi-fru.h mentioned in the MAINTAINERS entry.
>
> Later, commit d5d4aa1ec198 ("MAINTAINERS: Remove FMC subsystem") from
> Denis Efremov cleaned up the MAINTAINERS entry, but actually also missed
> that include/linux/ipmi-fru.h should also be deleted while deleting its
> reference in MAINTAINERS.
>
> So, deleting include/linux/ipmi-fru.h slipped through the previous
> clean-ups.
>
> As there is no further use for include/linux/ipmi-fru.h, finally delete
> include/linux/ipmi-fru.h for good now.
>
> Fixes: d5d4aa1ec198 ("MAINTAINERS: Remove FMC subsystem")
> Fixes: 6a80b30086b8 ("fmc: Delete the FMC subsystem")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Linus, please pick this patch.

OK applied this to the GPIO tree, thanks!

Yours,
Linus Walleij
