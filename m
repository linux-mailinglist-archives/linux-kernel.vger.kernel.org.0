Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2534F13E09E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 17:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbgAPQof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 11:44:35 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34537 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbgAPQob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:44:31 -0500
Received: by mail-qk1-f193.google.com with SMTP id j9so19746390qkk.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 08:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4y7BXaK3p6Ev3rLxUss//ZBuzibYMlRBSCu9vxh8o1Y=;
        b=BSL9HYg6dKP4eDQO8ZxgXD3fUPn57epnIYfd8yF5xp1iPMgE/zFnY+UYwobWOthu0J
         nlV6y0MM6WFUEPMD9BshpweVInH9ZUgnc+uJ/uaCO5JdW8saMWTw8J+IcQ2qnbzV/Bmn
         hkUEhT9/o5uSxWH1Rf18F/jfpcQmgkm3ktLphptZDrakZem0/OOFuriVYYOib4jnTj1l
         d8ffmDMGHGUdlao/hClAbQlxxjvJ8EPxKWsSB+jJihR+ltOH99Pu3ZD8hJevNOS8nQyo
         B+YpBEPippvdXesV6mjvcPDThp3TPrvnNdEr/vCc1Enbw8pOYNbFY0udN7g57aZnhsFo
         hhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4y7BXaK3p6Ev3rLxUss//ZBuzibYMlRBSCu9vxh8o1Y=;
        b=p0oJnP3HooQ2i9knuSZ7zwCEeKE9FWJ/uzE2a8zs4auGVBc1tqUs8Xz4O7ikZ66oQa
         InDoJzrPC/noLOxB7TUpiEbC1QNOlI3M4bIjCaLWthASL09oqmm00TrTwGaYHKdsP9Oo
         i7oaemoiGY7kG0tX8P2VfGSUND/vN9njagBQiyUwxYalYiERwzv4+FMfIW7c6vLE+iSG
         horq/T3uM2feuZEzR94opDe4cCOAULbqTIB2l1wRq8+RdbHcsnQZo6r25cR3tPLuUSKU
         eZAi+zatjoDkQrLAjlyLKz/RF2szFa6blRqhOWm1LYOtM93rAO12I5crIVmHH1TlTT5t
         hzyw==
X-Gm-Message-State: APjAAAV7YDN6xNR+7g0SbgDUBaoRK91SxqO8WaMldwfGDA8uGtQpAOJG
        C4ZfJh6PWBx5okR+nq9RwYE5uA==
X-Google-Smtp-Source: APXvYqzmh8bO/hET09TGMCFDXvlQk2DI1M84T9VpwtnCHyzmMAPYH3MdTYzKU2zFnxSiP5ohjWtXuQ==
X-Received: by 2002:a37:4905:: with SMTP id w5mr16900444qka.267.1579193070001;
        Thu, 16 Jan 2020 08:44:30 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::ae73])
        by smtp.gmail.com with ESMTPSA id b81sm10334905qkc.135.2020.01.16.08.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 08:44:29 -0800 (PST)
Date:   Thu, 16 Jan 2020 11:44:28 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 2/6] mm: kmem: cleanup memcg_kmem_uncharge_memcg()
 arguments
Message-ID: <20200116164428.GB57074@cmpxchg.org>
References: <20200109202659.752357-1-guro@fb.com>
 <20200109202659.752357-3-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109202659.752357-3-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 12:26:55PM -0800, Roman Gushchin wrote:
> Drop the unused page argument and put the memcg pointer at the first
> place. This make the function consistent with its peers:
> __memcg_kmem_uncharge_memcg(), memcg_kmem_charge_memcg(), etc.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
