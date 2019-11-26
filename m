Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0322109A56
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 09:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfKZIm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 03:42:59 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40915 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfKZIm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 03:42:59 -0500
Received: by mail-wr1-f66.google.com with SMTP id 4so18076659wro.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 00:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JHNZUTPIMG+8vm9Xx7nqvxw7Hrw7f/tddmrI9dcAnk8=;
        b=CJV6ZYyKMABUO8sf/kvxRG1FphfBIzrIl/CVoIglL0z9uB6aMJrRc6kD0mwGKBlb5w
         IqPm6qOrqH2nyG0KPUls1bgLf9VGY6Hv+QYX8BF0KfscBWJmjkuurdbFuAXutMeSvhMP
         dG5tRgq7FJSADMvInlQA/GdDSbTK2HFx4h590=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=JHNZUTPIMG+8vm9Xx7nqvxw7Hrw7f/tddmrI9dcAnk8=;
        b=RCcon9xderkfCShxTOBPF/3kDyK+kFXk/yOzKH7P5nikLPKC02iO//Sx9WSvW1qp1H
         496YdOJ55Es67mkNIPx7JLEkMr22n1Dnp0PKE6f3mhwjeOJ74zhyCWGLB7a1xFzB26qz
         80GYMFA3C4bcvRNWU3hWWdCajZFyzBqrk+H+SIMOja0krqPv3ZhPYJw+iQHH+0+tml05
         o/XOg47WMNWtlyEpHhfpawTQMziwPLTM1f2kb1aaGJdHlF58Bigr5dRIx9WlOYbUqVRd
         ZNiu4kVmOl6Lq5iQCExUqZnMGIBSxU/R6aM5BJVNQ4LE+NXyOgMPOQc9Ctfmpk+yNdK6
         onXA==
X-Gm-Message-State: APjAAAW10/i7xKQekAokiQKhYawSwU5rizRuoLJqmWb8rFUMpAf5QCnq
        5MrEenmQs+51EKgy0ZMOgz8ulQ==
X-Google-Smtp-Source: APXvYqyLSv+QdXGnFV3g1p8B1aJHrD8G2pitYUfElplL8wg7O0YAPimG7NTzRuqe30vr+WEPIOitpQ==
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr22353641wrj.340.1574757775944;
        Tue, 26 Nov 2019 00:42:55 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id b1sm14040556wrs.74.2019.11.26.00.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 00:42:55 -0800 (PST)
Date:   Tue, 26 Nov 2019 09:42:53 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     syzbot <syzbot+1e46a0864c1a6e9bd3d8@syzkaller.appspotmail.com>
Cc:     airlied@linux.ie, chris@chris-wilson.co.uk,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        rafael.antognolli@intel.com, rodrigo.vivi@intel.com,
        shli@kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in md_ioctl
Message-ID: <20191126084253.GP29965@phenom.ffwll.local>
Mail-Followup-To: syzbot <syzbot+1e46a0864c1a6e9bd3d8@syzkaller.appspotmail.com>,
        airlied@linux.ie, chris@chris-wilson.co.uk,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        rafael.antognolli@intel.com, rodrigo.vivi@intel.com,
        shli@kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000a52337056b065fb3@google.com>
 <000000000000f4160705983366e8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000f4160705983366e8@google.com>
X-Operating-System: Linux phenom 5.3.0-2-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 02:37:01PM -0800, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit 4b6ce6810a5dc0af387a238e8c852e0d3822381f
> Author: Rafael Antognolli <rafael.antognolli@intel.com>
> Date:   Mon Feb 5 23:33:30 2018 +0000
> 
>     drm/i915/cnl: WaPipeControlBefore3DStateSamplePattern

This seems very unlikely, the reproducer doesn't open a drm device, and
I'd be surprised if your gcd instances have an actual i915 device in them
(but I can't check because boot log isn't provided, didn't find it on the
dashboard either).

Since i915 is built-in I suspect this simply moved something else in the
kernel image around which provokes the bug.
-Daniel

> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13aeb522e00000
> start commit:   c61a56ab Merge branch 'x86-urgent-for-linus' of git://git...
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=106eb522e00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=17aeb522e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4013180e7c7a9ff9
> dashboard link: https://syzkaller.appspot.com/bug?extid=1e46a0864c1a6e9bd3d8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16bca207800000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14819a47800000
> 
> Reported-by: syzbot+1e46a0864c1a6e9bd3d8@syzkaller.appspotmail.com
> Fixes: 4b6ce6810a5d ("drm/i915/cnl:
> WaPipeControlBefore3DStateSamplePattern")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
