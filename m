Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99B4364FB7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 02:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfGKA4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 20:56:45 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35730 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbfGKA4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 20:56:44 -0400
Received: by mail-oi1-f193.google.com with SMTP id a127so3165565oii.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 17:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AalxJ/0/4/HhJ4tT+kKi8ndOcJn6LMuItEJqdKXAcas=;
        b=feDM+JzLX6ZYupFIs1WJex58Bh6TfL3ayl08gQisIdm7ErZl/DncNAUvnAIlLKOmUq
         e+6Ki1Ejt6mbzvwjUqNZT9GUqHKRX6lNivSrOZ/9XBP7J2XsQs+kfXlDOATp4w9+bhW1
         RojnFUs/1i5y52KZPkyQ4i/dvW21+afF0Kkeo6dP60akxJGHHWbiLzfSK/b5KdSmiyMB
         E4PJ1cau+i5Xz93yta5MXDbAHKurEkEbjwn4QqMDSuotETqP04+u6FYsyORTvOzNQybE
         EvIa/bVZnsFpM7uM1A+dEDg60AaU9eOWIFVWnrF7G0iah4Byc50A52zpAzL4tmMvakpA
         dn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AalxJ/0/4/HhJ4tT+kKi8ndOcJn6LMuItEJqdKXAcas=;
        b=RVBMgzv1t3+SxSn4jUeaQk4H0gajm35qft5WzsQpvK5QhPLn0ormXrOKd7FQdKzV+Y
         KQ165Arq7XUhZVe6q0Yf42DiGx1nQ7MX3h3U7yAj7Y6xn/IsUFlXpJoAsVWdo2F6KtZ9
         Agvw7eDkFCp+9tWXg5dQCHEjDsSXDCJKxND+xr58kWYjY/xi4NUZ1qKMo5dCiGlhDuC6
         HVdWJJdIyhqWdssqc094ZDLcSaXlifci7asIPxrxwXzPcpjIfI5EK6YtPwLc0+f9wRZs
         wG2Tb6NMtLYeqJX64/ZxSCxAww2/3tnH5c6sXO7Eip4OtWdmA6jJs2kaaR02MzKOpUsQ
         ZwNA==
X-Gm-Message-State: APjAAAWrsfNv4XKRzQyY4YgtccN5hE7bLwSS8Hzow0ockqhq2F8HZNi+
        BzewN5DONO6855Nzi46I540ubeX+/U++muAZWHrolQ==
X-Google-Smtp-Source: APXvYqzUq43i3qVgeErFkn+22Myvu3MI/Z5yKlci8Ref6fCz1j4jeuFWDBz+2XjUbAzKbthQs7NBdBR/53DRrdbqdNM=
X-Received: by 2002:aca:4d84:: with SMTP id a126mr769189oib.23.1562806602830;
 Wed, 10 Jul 2019 17:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190710105119.22987-1-codrin.ciubotariu@microchip.com>
In-Reply-To: <20190710105119.22987-1-codrin.ciubotariu@microchip.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Thu, 11 Jul 2019 08:56:32 +0800
Message-ID: <CA+Px+wWa9MvK4UVqsrMGtSQ=ZUSQrX837JFma5EYdhu465YhXg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: codecs: ad193x: Use regmap_multi_reg_write() when initializing
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     ALSA development <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lars@metafoo.de, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 6:51 PM Codrin Ciubotariu
<codrin.ciubotariu@microchip.com> wrote:
>
> Using regmap_multi_reg_write() when we set the default values for our
> registers makes the code smaller and easier to read.
>
> Suggested-by: Tzung-Bi Shih <tzungbi@google.com>
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>

LGTM.  Thanks.
