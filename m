Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7679180319
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 17:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgCJQUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 12:20:35 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44946 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgCJQUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 12:20:34 -0400
Received: by mail-pl1-f193.google.com with SMTP id d9so5612067plo.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 09:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rg0tlZ1r5JJSgGcfqdLNC6be2wreThrQF0bm9V2CBP4=;
        b=v9PIceElWnxeoXavqqCMcnerPOpJvkrkNi3DANFBANHLHVl/niXJnuUxZmYB7ZOUVM
         JEDa06Ujtlf38WeXQEe+PTgybub9Sow/4YlhM+WK2gV2fY+vBoMXblF+4EpANux0jrvM
         CaDLNaiI1ZkmUnNwqLa/CQgl/FvoYsW7vhehtBj+1sUQ6BPJDYupNk3lG1UwJeoubBHx
         5kTO6NGK87n2+L9r+THud1I8J0UemaZe1WBiqJcWJNb6ac+YuZM9pboZ0pe/YUll2UD4
         2+aXb/GoLxjMfxM8Bk4M40b16R0/Q7lykhJiMq8NyVQ3mNanYkhvMCbshOieJsrEca9Q
         INLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rg0tlZ1r5JJSgGcfqdLNC6be2wreThrQF0bm9V2CBP4=;
        b=neG43Dee1fbf78/nYPjfpRD9PUKzE9oseeH8HIJyM+ibYdYqrWeb2ja3xfR6bDuijK
         8L8POKfTbmTqq53ESw7dhYpIqnF3/Q1EElXIv0+c2ya4GorR/U6jyPi3V8pxHeddgdge
         9NgGHwR+2HCHoGYByJMNjWI43vi62o2YM8aJyU/qNRTEeCuNEE5NwpcOC2PEnJVcVn6W
         eyhd0Ch6ZqjXNPoOcPnPRIApKVAHatuTnnrK3Z3s7HCEzNSRjDFIq072hQNmKgjBrQdK
         3sbthdM4Mn78B1MoTss+WlomKnx6kQTJTzsyXwpkkE3oxKNhnmkSkH6/vi/uPHOYBtBV
         l2tQ==
X-Gm-Message-State: ANhLgQ1Tja6FdKPCPwXJMPAeJXqpfoLtJ10dGDZ+EOC/cm6Z8GswKIDr
        J0J0mm3+RdPqLuSdwfSC5vrIUg==
X-Google-Smtp-Source: ADFU+vsFBTyYg3pyF/6xABWJSKEizlfKeZ+CfT0J6b5nMVn41NLuvqaAgXzNDD0JN7sFwpw3NnRNHw==
X-Received: by 2002:a17:902:346:: with SMTP id 64mr20737899pld.226.1583857232709;
        Tue, 10 Mar 2020 09:20:32 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 144sm51121112pfc.45.2020.03.10.09.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 09:20:31 -0700 (PDT)
Date:   Tue, 10 Mar 2020 09:20:29 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Cc:     Andy Gross <agross@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v4 1/4] remoteproc: Traverse rproc_list under RCU read
 lock
Message-ID: <20200310162029.GI264362@yoga>
References: <20200310063817.3344712-1-bjorn.andersson@linaro.org>
 <20200310063817.3344712-2-bjorn.andersson@linaro.org>
 <87a14705-186d-01a4-e8a5-1844dab4ea14@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a14705-186d-01a4-e8a5-1844dab4ea14@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10 Mar 06:41 PDT 2020, Arnaud POULIQUEN wrote:

> Hi Bjorn,
> 
> 
> On 3/10/20 7:38 AM, Bjorn Andersson wrote:
> > In order to be able to traverse the mostly read-only rproc_list without
> > locking during panic migrate traversal to be done under rcu_read_lock().
> > 
> > Mutual exclusion for modifications of the list continues to be handled
> > by the rproc_list_mutex and a synchronization point is added before
> > releasing objects that are popped from the list.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> > 
> > Change v3:
> > - New patch
> > 
> >  drivers/remoteproc/remoteproc_core.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > index 097f33e4f1f3..f0a77c30c6b1 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -1854,8 +1854,8 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
> >  	if (!np)
> >  		return NULL;
> >  
> > -	mutex_lock(&rproc_list_mutex);
> > -	list_for_each_entry(r, &rproc_list, node) {
> > +	rcu_read_lock();
> > +	list_for_each_entry_rcu(r, &rproc_list, node) {
> >  		if (r->dev.parent && r->dev.parent->of_node == np) {
> >  			/* prevent underlying implementation from being removed */
> >  			if (!try_module_get(r->dev.parent->driver->owner)) {
> > @@ -1868,7 +1868,7 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
> >  			break;
> >  		}
> >  	}
> > -	mutex_unlock(&rproc_list_mutex);
> > +	rcu_read_unlock();
> >  
> >  	of_node_put(np);
> >  
> > @@ -1925,7 +1925,7 @@ int rproc_add(struct rproc *rproc)
> >  
> >  	/* expose to rproc_get_by_phandle users */
> >  	mutex_lock(&rproc_list_mutex);
> > -	list_add(&rproc->node, &rproc_list);
> > +	list_add_rcu(&rproc->node, &rproc_list);
> >  	mutex_unlock(&rproc_list_mutex);
> >  
> >  	return 0;
> > @@ -2140,9 +2140,12 @@ int rproc_del(struct rproc *rproc)
> >  
> >  	/* the rproc is downref'ed as soon as it's removed from the klist */
> >  	mutex_lock(&rproc_list_mutex);
> > -	list_del(&rproc->node);
> > +	list_del_rcu(&rproc->node);
> >  	mutex_unlock(&rproc_list_mutex);
> i'm not familiar with rcu but as rproc_panic_handler can be called in interrupt context, 
> does mutex should be replaced by a spinlock?
> 

Code traversing the list doesn't need to hold a lock, because the
rculist implementation ensures that the list itself is always
consistent.

Updates however can not be done concurrently, so that's why we're
maintaining this lock - which can be a mutex, because it now only
protects modifications.

And then the last piece is to guarantee that a node is not freed while
it's being accessed by the code traversing the list. This is ensured by
the synchronize_rcu() call below, which makes sure that no code holding
a rcu_read_lock() is still traversing the list.

Regards,
Bjorn

> Regards,
> Arnaud
> >  
> > +	/* Ensure that no readers of rproc_list are still active */
> > +	synchronize_rcu();
> > +
> >  	device_del(&rproc->dev);
> >  
> >  	return 0;
> > 
