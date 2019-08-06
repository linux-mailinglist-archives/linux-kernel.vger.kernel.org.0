Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAF2837EE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 19:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387476AbfHFRdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 13:33:37 -0400
Received: from ms.lwn.net ([45.79.88.28]:45134 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732766AbfHFRdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 13:33:37 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2BD88728;
        Tue,  6 Aug 2019 17:33:36 +0000 (UTC)
Date:   Tue, 6 Aug 2019 11:33:35 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 0/3] Convert some RCU articles to ReST
Message-ID: <20190806113335.67a1c940@lwn.net>
In-Reply-To: <20190730231030.27510-1-joel@joelfernandes.org>
References: <20190730231030.27510-1-joel@joelfernandes.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2019 19:10:27 -0400
"Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:

> This patch is a respin of the RCU ReST patch from Mauro [1].
> 
> I updated his changelog, and made some fixes.
> 
> [1] https://www.spinics.net/lists/rcu/msg00750.html
> 
> Joel Fernandes (Google) (2):
> docs: rcu: Correct links referring to titles
> docs: rcu: Increase toctree to 3
> 
> Mauro Carvalho Chehab (1):
> docs: rcu: convert some articles from html to ReST

So what is the plan for this series.  Paul, do you want to take it...?

Thanks,

jon
