Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFA812E85B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jan 2020 16:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgABP5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 10:57:18 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36734 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgABP5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 10:57:18 -0500
Received: by mail-lf1-f66.google.com with SMTP id n12so30170854lfe.3;
        Thu, 02 Jan 2020 07:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6nJzNxoHHP2qeQwJAX7JtKv6dI5N1gKdyhYamT8Rigk=;
        b=l3fFiR4LY1WvW8xQWZy2Yq/6iUVx9c1wc1ZM8GnmvPQbaRrpJRKULjQKkF3TKR0F38
         wTIV1g4wHUyMmbeEH/YkwmPhsb/Zav1cQKsRxaHfvwJ+eCFOS+yYi1ioQqEYoWNWxU5u
         2DQ0rjcH+gOVH7n+8K9atyKtPV4W1Uu6gQj7RtLHsMnQ9iSIXROptDfJ1huIy6E/uWcs
         +rVcm3sYkOT9YVIcFKyBSCKS48k1dMnkcl/Yi/AoDaD5pnrYoz7J+1Z8ufvAq6HkB/zU
         ojMQ+Q31MOyx4wedjoaOe7o0xto7QS6DKcQZ1o1kUPi34/74vJwBadCG/6Gy4vaI9xOC
         ehzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6nJzNxoHHP2qeQwJAX7JtKv6dI5N1gKdyhYamT8Rigk=;
        b=lMIZcs1NjkEW+YhJhDbFUsIOq3TIVLAAfOlOGtP+jwoDb7IkNWcr9bMiydsxecybAT
         Pm/jxcABwmqveKurq63iFgCuyO9n2qcTvJAzazf7t/NB0Ap9VdTnS3tD5ozNEbUIimOA
         3zkg4Tsayh5CKXqc29c2PK0PY97afVw4+7aBTa5Emn3vpF0O6e0OkxRjdYqPvU8puexv
         gtMPC9NIjcwvucYS/x+BKTTC7WMQMsGAMk4jE0cUJtolbdHh23gvlG220X0Z1/fZc8xB
         K7VEwds6Yaay5ngsQfLHID3oLDs354ZuhoMuVnYGWFRNQRy9xsvujeumUx6nQ4hSb77j
         ytxQ==
X-Gm-Message-State: APjAAAUuL6fwFTuUat8Y0jdCuIUyEjVnsPYvJKRqhYRdsWe/Vrzzcm/b
        O8l2QCQ0DpaR7FRG8SmzJNgW7Mtm
X-Google-Smtp-Source: APXvYqwBEgyRMN2xwOc7zrBPderdE1gHsR38bw0rFNEK+8PQNUje3gqEWIQwQ1Qzlhl2uZkLaFsj4Q==
X-Received: by 2002:a19:2d0d:: with SMTP id k13mr46205902lfj.12.1577980636121;
        Thu, 02 Jan 2020 07:57:16 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id r20sm23384004lfi.91.2020.01.02.07.57.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2020 07:57:15 -0800 (PST)
Subject: Re: [PATCH v1] ASoC: rt5640: Fix NULL dereference on module unload
To:     Mark Brown <broonie@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, linux-tegra@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20191229150454.2127-1-digetx@gmail.com>
 <20191231001719.GC3897@sirena.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <03ccf221-697e-bc34-f4ba-bf191aecd675@gmail.com>
Date:   Thu, 2 Jan 2020 18:57:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191231001719.GC3897@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

31.12.2019 03:17, Mark Brown пишет:
> On Sun, Dec 29, 2019 at 06:04:54PM +0300, Dmitry Osipenko wrote:
>> The rt5640->jack is NULL if jack is already disabled at the time of
>> driver's module unloading.
>>
>>  Unable to handle kernel NULL pointer dereference at virtual address 00000024
>>  ...
>>  (rt5640_set_jack [snd_soc_rt5640]) from [<bf86f7ed>] (snd_soc_component_set_jack+0x11/0x1c [snd_soc_core])
>>  (snd_soc_component_set_jack [snd_soc_core]) from [<bf8675cf>] (soc_remove_component+0x1b/0x54 [snd_soc_core])
>>  (soc_remove_component [snd_soc_core]) from [<bf868859>] (soc_cleanup_card_resources+0xad/0x1cc [snd_soc_core])
> 
> In addition to what Takashi said:
> 
> Please think hard before including complete backtraces in upstream
> reports, they are very large and contain almost no useful information
> relative to their size so often obscure the relevant content in your
> message. If part of the backtrace is usefully illustrative then it's
> usually better to pull out the relevant sections.

Yeah, perhaps it's not really useful to have backtrace in the commit's
description for the case of this patch in particular. But in general it
is very useful to have backtraces somewhere near the patch such that
online search engines, like google, could pick it up. I'll move the
backtrace below --- in v2, thanks.
