Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4D77B66E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 01:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfG3X5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 19:57:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53250 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbfG3X5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 19:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nLImo0QgwL+GI9wIFh3eNs6gA530BwbjFLbIxMV0sgM=; b=UyzNtt6hMaJlEFALNVMK37+eL
        IeDCrq8WQwsFoFUx64vo2U6MqAkxcbrr9Eru4tWqLNk4g2zBXuCGaAOXMh1HqNeOFKt26G00rlT+q
        //SWtsnmkrlqiGIG0ymlcauv81B6avDidcg8u0kKFC7lPWRf30qKL9n+2ukjOMebyEl7fWG4hjyw3
        GQlGLkPNU7ebwsZA9RPrx8evZdvq6ImJXI2ijuwIlJ3KvSHc5ho/+0PIHRYfjV5O8P+MI4/lG2VSt
        tTXSWHXog5jHG6qOCpkySpzfYfe0Tb1UfnUlpksCDmvPdDqzZKBckhcjbGZuV4dkBk0Ni3mjTg+La
        9h9+2d7JQ==;
Received: from [177.157.101.143] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsbzS-0006uA-Cm; Tue, 30 Jul 2019 23:57:10 +0000
Date:   Tue, 30 Jul 2019 20:57:04 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 3/3] docs: rcu: Increase toctree to 3
Message-ID: <20190730205704.2bd7b45c@coco.lan>
In-Reply-To: <20190730231030.27510-4-joel@joelfernandes.org>
References: <20190730231030.27510-1-joel@joelfernandes.org>
        <20190730231030.27510-4-joel@joelfernandes.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 30 Jul 2019 19:10:30 -0400
"Joel Fernandes (Google)" <joel@joelfernandes.org> escreveu:

> These documents are long and have various sections. Provide a good
> toc nesting level.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  Documentation/RCU/index.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
> index 94427dc1f23d..5c99185710fa 100644
> --- a/Documentation/RCU/index.rst
> +++ b/Documentation/RCU/index.rst
> @@ -5,7 +5,7 @@ RCU concepts
>  ============
>  
>  .. toctree::
> -   :maxdepth: 1
> +   :maxdepth: 3

Makes sense to me.

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Thanks,
Mauro
