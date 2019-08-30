Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 694C4A3AFC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 17:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfH3PvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 11:51:05 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38924 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbfH3PvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:51:05 -0400
Received: by mail-qt1-f196.google.com with SMTP id n7so8077372qtb.6;
        Fri, 30 Aug 2019 08:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mgOK+4EfzrzqKzAOXuYJVaIrWdAPC+wCshpIrSxOVWo=;
        b=lBpuogk7Jq4wq3D79s4tff/roknGXtcgIc5Ej2HHnyKukQw8PRGj4Yqi+jHA4IhXUJ
         rW88Gef6srA8l/7TOSiRW0OHhKUlnlG7usKems1SicB1+tpxFOaLaAXw+b9IiuL9HLNg
         GGSvUxZpXMQgi/dvpRiSuq5ERxIAsak//7sO2SmODIUtoXqwDFm13ZzRhDSKchlnXyXP
         UPsWmMLyd73IJIvZFAXcrVY5XQU9bNRn1nEePBvtH12VdYI92VWHTP3wGuyMm1jiImqM
         kfxyA9Ddg4mGFAmYW5roOsNjPI3EAmCobHBHYlnT2qGSzZqY6l+OBrkIfTwRQJMf/IIH
         s3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mgOK+4EfzrzqKzAOXuYJVaIrWdAPC+wCshpIrSxOVWo=;
        b=OIt4dLD+mO4T7H/vvGsf/9meZVzT3rTIL2Da7qYsWLxlA53CQKdbowgC3gUrf3urE9
         ieIAqMZLo2pf0WKJrp2BkmL48+qigoa1sGp16UTcfT0jO9mft9WEWQdK41xp+Wi4Xf6W
         TY7aXpmPmONr7wlh+wBB0/rapsVOn2EfJNn/U7VrwaSOmjT+5oXKmANQM8KIJl39dcqw
         9+2Oqno7cPl0/AAFcdHdVJy6siQreGgszQPdOr+wgB88TrftM0JbSgfBcfyVa3PFfYRC
         52mijx8Qs8Lyzf/MO0xFwfFGSJCHbBtV5g7MX1UsABi3cqfiRAv7fT34cOC/7OVa07FH
         jknw==
X-Gm-Message-State: APjAAAXHJhdl8YyPHp45QfFglCb8HtVAQ2OF2yJY2iI6g3FT8wxEvMTw
        13BsyI+I3AVQVvD3e+QO6C0=
X-Google-Smtp-Source: APXvYqxWLLbDQHb495M0qaRjsinqF4egCG84dCcabK1WCpU8rv75mI9EsdOe/lr6lb8vsmI2IK0JOg==
X-Received: by 2002:ac8:7504:: with SMTP id u4mr15187775qtq.81.1567180263853;
        Fri, 30 Aug 2019 08:51:03 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::d0dd])
        by smtp.gmail.com with ESMTPSA id s4sm2782788qkb.130.2019.08.30.08.51.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 08:51:03 -0700 (PDT)
Date:   Fri, 30 Aug 2019 08:51:01 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH block/for-next] writeback: add tracepoints for cgroup
 foreign writebacks
Message-ID: <20190830155101.GA2263813@devbig004.ftw2.facebook.com>
References: <20190829224701.GX2263813@devbig004.ftw2.facebook.com>
 <20190830154023.GC25069@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830154023.GC25069@quack2.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 05:40:23PM +0200, Jan Kara wrote:
> Are the page dereferences above safe? I suppose lock_page_memcg() protects
> the page->mem_cgroup->css.cgroup->kn->id dereference? But page->mapping
> does not seem to be protected by page lock?

Forgot to respond to the mem_cgroup part.  The page to memcg
association never changes on cgroup2 as long as the page has ref, so I
think that one should be safe.

Thanks.

-- 
tejun
