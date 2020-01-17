Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 315AE140CBC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 15:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgAQOj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 09:39:27 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40661 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729052AbgAQOjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:39:09 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so7843234wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 06:39:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FM5gEGcsHSheJ12PrG+98Z8Dj8YPcurFe/MH3OksWAw=;
        b=ZzwNHhAnRxWxK+FXiIiW6ReNUZk7w/LobHPoGcHVM+kCY+9oXjaJWPRmIiGTu6pLxw
         xXDPDvVhSugRB/DX0RMs+CoBs3P9D7xGb2CyS2OiGNXQJ0R3FRycFtHOhJNSr0ZH/W2g
         NLt/BAf3TlXYB33WqwaNjbaXjHxQa6aRPN3uQaGseBva3ukOE9bzUzAG7hR1I9xA9u5d
         hfBSmQXSiV4NYY1w01gxz5QW0hPsWwr39Wx2F2afkYCSUKdzb7jaeoL4n8DY0wHFyYHW
         OR6EQSQXKoLrREaqtYZj376FE7Z3TtjbTvB11S3c8affwFaN3NQ64STpi0nzju+kbfps
         e47g==
X-Gm-Message-State: APjAAAXoREIeB4nWX/ef3hzpJvkvD+MaCZZruhmSYqnkyxgorfOpuEqy
        pC6cdKh2SEFD3V68L+/sLvQ=
X-Google-Smtp-Source: APXvYqzVF3pbj3oMNV3iX2AlQnmMcecSG3DD2gDbw611onsa7CvlSFe7qX5XdSKsJsVVEJELfxaSzA==
X-Received: by 2002:a1c:770e:: with SMTP id t14mr4876275wmi.101.1579271947194;
        Fri, 17 Jan 2020 06:39:07 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id q14sm1287466wmj.14.2020.01.17.06.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 06:39:06 -0800 (PST)
Date:   Fri, 17 Jan 2020 15:39:05 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, sergey.senozhatsky.work@gmail.com,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v4] mm/hotplug: silence a lockdep splat with
 printk()
Message-ID: <20200117143905.GZ19428@dhcp22.suse.cz>
References: <20200117085025.GJ19428@dhcp22.suse.cz>
 <9A869A12-E2D3-4952-9103-8444506425BE@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9A869A12-E2D3-4952-9103-8444506425BE@lca.pw>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17-01-20 07:32:15, Qian Cai wrote:
> 
> 
> > On Jan 17, 2020, at 3:59 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > Thanks for the updated changelog. Btw. do you plan to send a patch to
> > move WARN_ON_ONCE as well, or should I do it?
> 
> I’ll send a v5 anyway, so I’ll could remove that for you.

Thanks a lot. Having it in a separate patch would be great.

-- 
Michal Hocko
SUSE Labs
