Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE7917A926
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 16:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgCEPrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 10:47:02 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:40508 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCEPrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 10:47:01 -0500
Received: by mail-qv1-f68.google.com with SMTP id u17so1295123qvv.7;
        Thu, 05 Mar 2020 07:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2+6yZWLzWungFxfinpVR8DrsNx/2sba2y67ZFb8NhxY=;
        b=LucVZ0IhRZuskZG477RZ59HOO2HEwkbxzbAF+WksjcG6JkEBMfrYnSJ6kIoJaxpe8U
         D0H8In8ybFuNvyAKewp5CAtAdPuZ/7TMg4nCYtBQpggejWGCFQsIRdABK8dtz6mL+BeU
         XuNCfqUDVbuMdbNxe7vJ4AzlSKD0qGCMcHM2302Xs1thPjBf1F40AbaQUxRK/9vs72R8
         6FNXwtKbiWWvcIGLKKNt38De2MsTYv9jS1zWvICVa9OUWpkTu9iKq0OLx3Io8ko5LlW7
         DOn81PctlHb5LVX3hralVTU0scu3W1+7e3gbfxIO+97njwh04F9Y0j9jzFLomBneRT9r
         0uGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2+6yZWLzWungFxfinpVR8DrsNx/2sba2y67ZFb8NhxY=;
        b=pFSE8EKUkyo1vI4lu8slSu3/Q0kzxggdMHUdm7n4a2FD/yiqCBMY7z3D0UZIWCdXIU
         NkYn//rhJqG5xyJwLURNXmFlFBV8hwWM7gYCq1LYB+Dx/R9FGyBrbvi7F31RJjMpDjdA
         N84w48jLGDFBgC3UfwN+si8Sp3Q9pFcYDZghWmXsCr+fDSwGllZWQEp241LTRssVfWmO
         XKOpae87/AUMaBBCP3T6+QMicUx000AF+2fqJIg302WGRtINjRHeZ7BVGOXKGVYRCoeN
         rev56B8KUqeOcb3F/PgiSVq8EhdXX12hl4cLM1d4+/7DHGiQT9NrZRdXA5izEohZoq20
         erPw==
X-Gm-Message-State: ANhLgQ2dpH6+3HhDi9XD0dstzEzGwMvtwc4IL1XomMt4ZOB2UOHgmfC2
        kpA1KE6y3cYCkQ5Fi2BZ61E=
X-Google-Smtp-Source: ADFU+vuDA7FZoPkQdDlfKUwDun6qmuJOcx4Ams7CpNGOdN41KFGO46LtijTZrAIP5HBnR1VjHAKw/A==
X-Received: by 2002:a0c:c389:: with SMTP id o9mr7182654qvi.232.1583423220640;
        Thu, 05 Mar 2020 07:47:00 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id f5sm6126935qtq.72.2020.03.05.07.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 07:47:00 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 5 Mar 2020 10:46:58 -0500
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Joe Perches <joe@perches.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Kees Cook <keescook@chromium.org>,
        "Tobin C . Harding" <me@tobin.cc>, Tycho Andersen <tycho@tycho.ws>,
        kernel-hardening@lists.openwall.com,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: Stop printing the virtual memory layout
Message-ID: <20200305154657.GA848330@rani.riverdale.lan>
References: <202003021038.8F0369D907@keescook>
 <20200305151010.835954-1-nivedita@alum.mit.edu>
 <f672417e-1323-4ef2-58a1-1158c482d569@physik.fu-berlin.de>
 <31d1567c4c195f3bc5c6b610386cf0f559f9094f.camel@perches.com>
 <3c628a5a-35c7-3d92-b94b-23704500f7c4@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3c628a5a-35c7-3d92-b94b-23704500f7c4@physik.fu-berlin.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 04:41:05PM +0100, John Paul Adrian Glaubitz wrote:
> On 3/5/20 4:38 PM, Joe Perches wrote:
> >> Aww, why wasn't this made configurable? I found these memory map printouts
> >> very useful for development.
> > 
> > It could be changed from pr_info to pr_devel.
> > 
> > A #define DEBUG would have to be added to emit it.
> 
> Well, from the discussion it seems the decision to cut it out has already been
> made, so I guess it's too late :(.
> 
> Adrian
> 
> -- 
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer - glaubitz@debian.org
> `. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

Not really too late. I can do s/pr_info/pr_devel and resubmit.

parisc for eg actually hides this in #if 0 rather than deleting the
code.

Kees, you fine with that?
