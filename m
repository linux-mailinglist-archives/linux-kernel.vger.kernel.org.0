Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98732174789
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Feb 2020 15:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgB2O4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Feb 2020 09:56:55 -0500
Received: from ms.lwn.net ([45.79.88.28]:42098 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727068AbgB2O4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 09:56:55 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 47EE7537;
        Sat, 29 Feb 2020 14:56:54 +0000 (UTC)
Date:   Sat, 29 Feb 2020 07:56:53 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Aman Sharma <amanharitsh123@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH v3] doc: Convert
 rculist_nulls.txt to rculist_nulls.rst
Message-ID: <20200229075653.2fd7ae3e@lwn.net>
In-Reply-To: <20200227180656.15187-1-amanharitsh123@gmail.com>
References: <20200227180656.15187-1-amanharitsh123@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2020 23:36:53 +0530
Aman Sharma <amanharitsh123@gmail.com> wrote:

> This patch converts rculist_nulls from .txt to .rst format, and also adds
> it to the index.rst file.
> 
> Major changes includes:
> 1) Addition of section headers and subsection headers.
> 2) Addition of literal blocks which contains all the codes.
> 3) Making enumerated list item by changing X) to X. where X is number
>    like 1,2,3 etc.
> 
> Signed-off-by: Aman Sharma <amanharitsh123@gmail.com>
> ---
>  Documentation/RCU/index.rst         |   1 +
>  Documentation/RCU/rculist_nulls.rst | 179 ++++++++++++++++++++++++++++
>  Documentation/RCU/rculist_nulls.txt | 172 --------------------------
>  3 files changed, 180 insertions(+), 172 deletions(-)
>  create mode 100644 Documentation/RCU/rculist_nulls.rst
>  delete mode 100644 Documentation/RCU/rculist_nulls.txt

When you put out multiple versions of a patch, it's always good to say
what has changed; you can put that information right after the "---" line
above.  That's even more true if you send two versions within minutes of
each other; recipients will want to know what is going on.

Thanks,

jon
