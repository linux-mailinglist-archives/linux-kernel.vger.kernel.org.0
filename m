Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD8C631D5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 09:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfGIHWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 03:22:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36780 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfGIHWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 03:22:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so19802819wrs.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 00:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eTTGtdAf9D8hMWA6RdwU6DYctiL/OmG776vwkKDwCdY=;
        b=D9zLoQTk2FJgkaohPSj2m1p1zwZI89NM//MF5PYnexgpgf4SiMH++rB5G5zVRxXhKr
         kYMteY2oyg2s8jY63/dsh9yMpX9CH7oYiLuARTVAqyvfM6mPxUEMXqwp6gJcF5qkCL1M
         1uCTJTTO+JhaYlbZ3q1P641qfafCLT3h+eVzHQkSA0iib/gyjCM884tf0Lp+lMFILUg4
         2ktc9iGkbEddgkAadHYi4SXOYsJOY2Jsh029gb4Ngmj8WpSmj+J69E2/ZuauZirjIO4t
         4ZqbT+H3xpjVasdiStsr8xD/UOZZKphkpHkshKaRkYKSC1l/3jT3N5m7Q7QMTM7l/c1v
         lVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eTTGtdAf9D8hMWA6RdwU6DYctiL/OmG776vwkKDwCdY=;
        b=OJBRogSrZJmRriBhDbtqro/mG3Ay6F6+WjZ5+aslAaSQ5xBSk8Fi4Fh0gwK0NW6En3
         9g0GcOGSK5SDcBmYOsU1nDpJc7f7jhDnkZXutXxNhA8iFJHtfTiVgI1qBtCGHyzrZec+
         B+wEP8XWM/84JcuNdkX9IMi0RImjGCSYc52T+0DO/7g2LZjucvWLnFWUDXe/v57Ruv+W
         fKDZJxpkizyNiwR0EJPYs0iJZ3bboQ7gRviM+t4v3z2HApOIIBCKHFgcXlr/le0NDzh7
         OxVeiKYlsfsmW+7GwaPuK3snsOn5EH+JwchK09+oT0Wc5TVif0K6dmLb9ULyX76Fld6t
         y6gw==
X-Gm-Message-State: APjAAAUAeJ5EPqwo1Be6GM5spIXZvYMHOPSuE5nr8+zne9/VF0bAsbTK
        sTSD/WxEVHEabWyIdxlRaxHcZ92bDc7qkw==
X-Google-Smtp-Source: APXvYqwpHuI9CWOWbco5N6jY+5LAeHjro1s1YTciZRy3YWL+F5Pp3hdmj4NAX2bBfyJX0mNGYk9vdQ==
X-Received: by 2002:adf:e28a:: with SMTP id v10mr23876027wri.178.1562656969476;
        Tue, 09 Jul 2019 00:22:49 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id l8sm32824144wrg.40.2019.07.09.00.22.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 00:22:48 -0700 (PDT)
Date:   Tue, 9 Jul 2019 00:22:47 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>, Rex Zhu <rex.zhu@amd.com>,
        Evan Quan <evan.quan@amd.com>, David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        clang-built-linux@googlegroups.com,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 0/7] amdgpu clang warning fixes on next-20190703
Message-ID: <20190709072247.GA92551@archlinux-threadripper>
References: <20190704055217.45860-1-natechancellor@gmail.com>
 <CADnq5_MGzLLMNPSQXpdxwrBpvsp7Fd1KdExS-K4yNeDBQYEGMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_MGzLLMNPSQXpdxwrBpvsp7Fd1KdExS-K4yNeDBQYEGMg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 11:55:50AM -0400, Alex Deucher wrote:
> Applied the series.  thanks!
> 
> Alex

Thank you :)

I don't see the enum conversion ones in your current tree. If they
indeed caused issues, could you guys please look into fixing the
warnings properly yourselves (maybe something like Arnd's patch?)
or let me know how you would like them fixed (explicit casts, changing
type to int, etc)?

https://patchwork.freedesktop.org/patch/316466/

Cheers,
Nathan
