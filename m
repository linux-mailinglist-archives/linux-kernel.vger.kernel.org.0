Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE2D144D1B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 09:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgAVIRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 03:17:35 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34879 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgAVIRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 03:17:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so6151475wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 00:17:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DvoS9npmCW10OIQIIaIERIR3pA8bTgXp4bivlZpaay0=;
        b=M5Itq0CcOH+1rgRyFFjeLlcm1fRXLXYNwrecbpzKtKDkq9cPyWhTa0VTqZpHdBSsdX
         +gbrEhA6KqjueWkvP7KZavp+yoLLKqPGKxW4EXf6pLYSBYJ8UmTbPXIKM16Vjj94W/wX
         zSP3UhfAYUT9Mcg26vA00nbFZPw4waJvyNvlOyhnOb5q7GVeGg3Y5mDbgYxv33a2TQGr
         r5lvNRvS4ftZGOGiME8ueSudbejT8n/oMoRtk3OJtI6XvoRZodP9s0m6EVmO2TB0SCUj
         S5Dp6gPbOhFs/KotQ2wUcvgk72KbjozxOhQYTpl3eFKc5bfPFdqoFy1bSavfTo6d7wIK
         tRug==
X-Gm-Message-State: APjAAAUVFv+k214Kq+dWwiIHurk/aKlAUNSt21IIdibYkzXtx2li747t
        VeHkNSb+W/8DJx6Y3FGY2AA=
X-Google-Smtp-Source: APXvYqyhOTgJm0qDXfGAFwwiFEyel7L6crkScLs6oinPtmRHKa5OezNsmABO1rObdbGfpFRUN1YoEw==
X-Received: by 2002:a7b:cbc9:: with SMTP id n9mr1624763wmi.89.1579681052568;
        Wed, 22 Jan 2020 00:17:32 -0800 (PST)
Received: from localhost (ip-37-188-245-167.eurotel.cz. [37.188.245.167])
        by smtp.gmail.com with ESMTPSA id b128sm2750616wmb.25.2020.01.22.00.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 00:17:31 -0800 (PST)
Date:   Wed, 22 Jan 2020 09:17:30 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yang.shi@linux.alibaba.com
Subject: Re: [PATCH 7/8] mm/migrate.c: move page on next iteration
Message-ID: <20200122081730.GQ29276@dhcp22.suse.cz>
References: <20200119030636.11899-1-richardw.yang@linux.intel.com>
 <20200119030636.11899-8-richardw.yang@linux.intel.com>
 <20200120100203.GR18451@dhcp22.suse.cz>
 <20200121012200.GA1567@richard>
 <20200121084352.GE29276@dhcp22.suse.cz>
 <20200122004012.GB11409@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122004012.GB11409@richard>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-01-20 08:40:12, Wei Yang wrote:
> On Tue, Jan 21, 2020 at 09:43:52AM +0100, Michal Hocko wrote:
> >On Tue 21-01-20 09:22:00, Wei Yang wrote:
> >> On Mon, Jan 20, 2020 at 11:02:03AM +0100, Michal Hocko wrote:
> >> >On Sun 19-01-20 11:06:35, Wei Yang wrote:
> >> >> When page is not successfully queued for migration, we would move pages
> >> >> on pagelist immediately. Actually, this could be done in the next
> >> >> iteration by telling it we need some help.
> >> >> 
> >> >> This patch adds a new variable need_move to be an indication. After
> >> >> this, we only need to call move_pages_and_store_status() twice.
> >> >
> >> >No! Not another iterator. There are two and this makes the function
> >> >quite hard to follow already. We do not want to add a third one.
> >> >
> >> 
> >> Two iterators here are? I don't get your point.
> >
> >i is the main iterator to process the whole imput. start is another one
> >to control the batch to migrate. We do not need/want more. More clear?
> 
> Yes, more clear.

Great

> I hope you are angry with me. Sorry for my poor English.

Heh, not at all.
-- 
Michal Hocko
SUSE Labs
