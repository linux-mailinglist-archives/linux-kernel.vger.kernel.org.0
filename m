Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27315174305
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Feb 2020 00:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgB1X0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 18:26:50 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45482 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgB1X0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 18:26:49 -0500
Received: by mail-lf1-f66.google.com with SMTP id d27so182194lfq.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 15:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jrhuf4lQMf789aXqjDV/8MVAbPHgK/nDIiXvOW13JOI=;
        b=rO+WDk956erxVFVfSU2H3hHLlMYNmDAMOXOFeD4pbkZcLgbyPe/Ae12DCeElQhhnfz
         nZjNfcgZoznCKshbRDD5RhDsgJtlQxstHP9qDymW/A3cSaP5ijZ83c7vzIkAkF/Yd9Ba
         iUC0bW/A6kBk/aD+uhICJQqrEgxrULwGvTbBbz/RvSn0/5aCu4DuFn8Xj7aXzNv+vJP9
         tnRmMa8VPCDwRyA1dfh1F59v3+RmYnFVBPRQJ69EHGZdifl6LhczqWbNVp4ori8EZWgO
         xCxsoDRNIuY/2iY6qme4j8zLvR3pMMc7YXkfDae9WgkGnPYSH5K00afmEHJwm1MPvAIv
         mHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jrhuf4lQMf789aXqjDV/8MVAbPHgK/nDIiXvOW13JOI=;
        b=EuvYt0Xj2MjQ7QDqzz+eFTS+gYpL4A2D9/QDCN8NQYTN5GrgLvWsuLlRncUbytLQtt
         1q3AJ60hjZdDjfuxqD3TJCNMNRqETO+n4DlgWhV3nl7oXkFQAGcHGrI1JomKtwcektJw
         1GS3gjbctFmSiG/DwuwT8BdvGPVK3jYPaRlx4ukWpDjqVl/HmVtbjh8GQy5vVNqGArxg
         5d/AshNeHse1W0gVTY7/tt8gKs4FSemYBjGkDlIZIcNzCMOzBwtGTtJ4NfN1ntB68B+6
         vN3d3Yx+9rK+SXzwv/Vx72Y4XHcMPe/DXSxFUcnsPUHWviEfs3TD+RonmQaevoLzOHH6
         FANg==
X-Gm-Message-State: ANhLgQ1IXuPyWDO8xQv9ZIp8iGHMp/lsqXgG5fk4Eg8TS2j+oaKan1x9
        v1bbZ3iQ92wxTGjaezHHpQtaRSJgnxYDU8s4ekBFlQ==
X-Google-Smtp-Source: ADFU+vvUMWfxluDt5eoB+Oyxc50yZOIsEYOtX4E9uDgWik3dzGkRingUQci7UbvajDnrKgRs33pWYVxrD7kHmz9g/yI=
X-Received: by 2002:a19:ed0b:: with SMTP id y11mr3895984lfy.77.1582932406150;
 Fri, 28 Feb 2020 15:26:46 -0800 (PST)
MIME-Version: 1.0
References: <f4e7e20afacb23e6fa7a6b33ea4319b2b3492840.1582776447.git.baolin.wang7@gmail.com>
 <d7239f3c7379e402f665fc8927f635ac56691380.1582776447.git.baolin.wang7@gmail.com>
In-Reply-To: <d7239f3c7379e402f665fc8927f635ac56691380.1582776447.git.baolin.wang7@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 29 Feb 2020 00:26:35 +0100
Message-ID: <CACRpkdYuWc5Okfgp3TO=iuJ_xSxoDkwN72Jim6=CSQC06s_n6w@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: sprd: Allow the SPRD pinctrl driver building
 into a module
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 5:14 AM Baolin Wang <baolin.wang7@gmail.com> wrote:

> Change the config to 'tristate' and export some symbols needed by modules
> to allow the Spreadtrum pinctrl driver building into a module.
>
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>

Patch applied.

Yours,
Linus Walleij
