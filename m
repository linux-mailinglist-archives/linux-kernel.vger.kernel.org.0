Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9916A112DBA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 15:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfLDOsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 09:48:36 -0500
Received: from ms.lwn.net ([45.79.88.28]:59562 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727887AbfLDOsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 09:48:36 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 189BE4FA;
        Wed,  4 Dec 2019 14:48:35 +0000 (UTC)
Date:   Wed, 4 Dec 2019 07:48:33 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Amol Grover <frextrite@gmail.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: Re: [PATCH] doc: listRCU: Add some more listRCU patterns in the
 kernel
Message-ID: <20191204074833.44bcc079@lwn.net>
In-Reply-To: <20191204082412.GA6959@workstation-kernel-dev>
References: <20191203063941.6981-1-frextrite@gmail.com>
        <20191203064132.38d75348@lwn.net>
        <20191204082412.GA6959@workstation-kernel-dev>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Dec 2019 13:54:12 +0530
Amol Grover <frextrite@gmail.com> wrote:

> The cross-reference of the functions should be done automatically by sphinx
> while generating HTML, right? But when compiled none of the functions were
> cross-referenced hence "``" was added around the methods (and other symbols)
> to distinguish them from normal text.

If there's nothing to cross-reference to (i.e. no kerneldoc comments)
then the reference obviously won't be generated.  I would still ask that
you leave out the literal markers; they will block linking to any docs
added in the future, and they clutter up the text - the plain-text reading
experience is important too.

Thanks,

jon
