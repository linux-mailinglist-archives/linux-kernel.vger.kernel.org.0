Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38617194FD1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 04:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgC0Duv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 23:50:51 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37681 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbgC0Duv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 23:50:51 -0400
Received: by mail-pj1-f66.google.com with SMTP id o12so3260796pjs.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 20:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TQKnjjnnFIx9OEk2sWZkIOZkXlTkDKqAFTfhqeOjSAk=;
        b=VM6BiVy3TJ+nvI5RskhEnSu7623UH7nfGrIKJl/ORWcGUF2lI8NS6I8irgEGdiq2XR
         vQtfjqf0TEgiA7T7gZBHv/CnE5Ro1vv4s1pZ5MibeXU9lI+oA9gnFOS9VKYlCjJi+b7Q
         3dJKWu+7FdIPsjaLQIzi//I9Vd3PCfFb2zs+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TQKnjjnnFIx9OEk2sWZkIOZkXlTkDKqAFTfhqeOjSAk=;
        b=etGdwU8qG8vYW3pLp2u02Ogazc2fg85Ohity8gYgHS3iO9YHYOWBjqKpcylejWzrji
         OWQh1x8mC/gpcrwKWsDN3cGqPuXMPZnEzmx+xuwRl4axo6/5iPAr5PRkWGEYsGNYCxHp
         yaWVNhpiDtqHg7PeqMq/JEoQ5cX0fVEaJZXzfpurnBG+NI8CAfW6rTQntuARnM9WY26R
         31SvkIVDevB1J0S1/9GC6+0tkAZ18FDbrUUO4g2PaX2mgBzeP5ciccDGHNVel6FaszpT
         2Uk+e6RwoeFt3Xo4Wxb2T2La6FuG8Gfofz1kGK/XBEr6+ASaexU9RBbXEAoe46+MXNnW
         V3OQ==
X-Gm-Message-State: ANhLgQ1iZP2A2W3Joo2SG+d19T6jB2bWKwTzkx8ktAQDcrhD2QJ5HUKB
        3YvB5a6IXBNgYRuCjWHQdz/MUg==
X-Google-Smtp-Source: ADFU+vsIQeYYJToUL3MPTGLgoCfpa8ooX6ORuBVJtQv23T7G5vwNOYygk3RRQrumo7g2y4wH6jmKwg==
X-Received: by 2002:a17:90a:fb47:: with SMTP id iq7mr3767952pjb.191.1585281049760;
        Thu, 26 Mar 2020 20:50:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c1sm2672036pje.24.2020.03.26.20.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 20:50:48 -0700 (PDT)
Date:   Thu, 26 Mar 2020 20:50:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>
Subject: Re: [RFC v3 1/2] kernel/sysctl: support setting sysctl parameters
 from kernel command line
Message-ID: <202003262048.70D845CDF@keescook>
References: <20200326181606.7027-1-vbabka@suse.cz>
 <202003261256.950F1E5@keescook>
 <8afebb97-db51-5744-dca9-840dc60cd396@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8afebb97-db51-5744-dca9-840dc60cd396@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 11:08:40PM +0100, Vlastimil Babka wrote:
> On 3/26/20 9:24 PM, Kees Cook wrote:
> I didn't want to modify param for the sake of error prints, but perhaps
> the replacements won't confuse system admin too much?

Ah, fair enough. Should be fine to do it against "path" then. Ignore
that bit from me. ;)

> >> +	filp_close(file, NULL);
> > 
> > Please check the return value of filp_close() and treat that as an error
> > for this function too.
> 
> Well I could print it, but not much else? The unmount will probably fail
> in that case?

Maybe? This is just a nit of mine from tracking horrible bugs that
turned out to be unreported 'close' failures. :)

> But I guess the "mount on first applicable argument" approach would work
> with this scheme as well:
> 
> struct vfsmount *proc_mnt = NULL;
> parse_args(..., &proc_mnt, ...)

Yes please! That would be perfect. (And yeah, it's a sensible
optimization to do it "as needed"; I hadn't thought of that.)

-- 
Kees Cook
