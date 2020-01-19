Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2505141DF4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jan 2020 14:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgASNDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jan 2020 08:03:37 -0500
Received: from mail-lj1-f181.google.com ([209.85.208.181]:46204 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgASNDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 08:03:36 -0500
Received: by mail-lj1-f181.google.com with SMTP id m26so31012895ljc.13;
        Sun, 19 Jan 2020 05:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N8EhJiBcFuLZDUwvKpZnAEaua94hgtTfgVZg/vOy6qU=;
        b=NZV9m+A2j/a1GYhCmFf/mu91SmgSMIboTRJbm35HNNjVOAq0ymHpcidVZmtdGIlkSa
         1hhOohdHg/+mKk4IOnQ9EJlLXE0ZYA56wneExjy5mavoODtPBVbM33Qanl9p8jYV2P57
         OX0wxN9SZnYwe1OUUJvrt2DDGv1phmS7hJeb6l02Jt+pPrGmOyPvUAJ58G1CjI1QcZhS
         UL1JlOqTgJJJj3fRwytLzrMT4QM5eSQsCQ9+I3/5nfwSivgUc5zyPKRhnTs+/NsbPg+v
         Wl6SmDi4XdAjrbuxOwcoP19JDL2tQInyoyzXYdD+uhP705IADdDAU7YVLPLyU3iM7V89
         X5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N8EhJiBcFuLZDUwvKpZnAEaua94hgtTfgVZg/vOy6qU=;
        b=GeDaQS+nY2BPGBbj8Yyp9TarEPPhYrZbxXP7DNd37YYrFP071ozEuwOyS1IU3kTDTZ
         LoVReTkc4Ikn1e3MByBR6a98Zarg5NWY9DM1jkc2N1qCWD14iWQ0U1nCVSKJccmyqSSS
         9cmnTJHdjZIbGcwN3mCp4JZS7DZk7pSCHrs9y9S0Bic/g1KC26K16OVha5/35SluFkHa
         iVuP2QxjJfofg+ebsc1iufcQPM9yvsXDqQ7OCjom4v7fD1jx7nmQ9RXBMi8hnM5m9M24
         w/VypGw5kJYbl3Fv0Mh5iXDBgUj6XTIlY2NvyR08697dDHoG0OVtoUa0L4LCmm2UGtmq
         DL9g==
X-Gm-Message-State: APjAAAUoYcip2uQvBWEAxsbpCRij3fqSTwXeFbjqj9DZiFSiOnnUo7c/
        kKsFptYnVh1VETzTWFQ63VTBMtWaG/V6hQ==
X-Google-Smtp-Source: APXvYqyPYddV/dUs+sH6lrIfbAvzUg63NwgidemQjzrKv7R0fLgN/dpXUA5GymREXBp0wf9XPmAkkg==
X-Received: by 2002:a2e:2201:: with SMTP id i1mr10789111lji.110.1579439014461;
        Sun, 19 Jan 2020 05:03:34 -0800 (PST)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id h81sm15105987lfd.83.2020.01.19.05.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 05:03:33 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Sun, 19 Jan 2020 14:03:26 +0100
To:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: support kfree_bulk() interface in
 kfree_rcu()
Message-ID: <20200119130326.GA19252@pc636>
References: <20191231122241.5702-1-urezki@gmail.com>
 <20200113190315.GA12543@paulmck-ThinkPad-P72>
 <20200114164937.GA50403@google.com>
 <20200115131446.GA18417@pc636>
 <20200115225350.GA246464@google.com>
 <20200117175217.GA23622@pc636>
 <20200117185732.GH246464@google.com>
 <20200117213721.GN2935@paulmck-ThinkPad-P72>
 <20200117215910.GC206250@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117215910.GC206250@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Paul, Joel.

> > 
> > Thank you both!
> > 
> > Then I should be looking for an updated version of the patch with an upgraded
> > commit log?  Or is there more investigation/testing/review in process?
> > 
> 
> From my side the review is complete. I believe he will repost with
> debugobjects fix and we should be good.
>
I have put the V2 on the test over the weekend, so i will post it next week.
Yes, V2 will contain the debugobjects fix. Also i need to add tracing probe,
something like:

..
trace_rcu_invoke_kfree_bulk_callback();
kfree_bulk(bhead->nr_records, bhead->records);
..

probably it can be done as separate patch.

Thank you.

--
Vlad Rezki
