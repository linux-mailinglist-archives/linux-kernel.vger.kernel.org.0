Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB5BF3776
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 19:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfKGSpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 13:45:11 -0500
Received: from ms.lwn.net ([45.79.88.28]:38948 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726859AbfKGSpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 13:45:10 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1B1156EC;
        Thu,  7 Nov 2019 18:45:10 +0000 (UTC)
Date:   Thu, 7 Nov 2019 11:45:09 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     linux-doc@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/kernel-doc: Add support for named variable
 macro arguments
Message-ID: <20191107114509.16ad9f5c@lwn.net>
In-Reply-To: <20191107134133.14690-1-j.neuschaefer@gmx.net>
References: <20191107134133.14690-1-j.neuschaefer@gmx.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Nov 2019 14:41:33 +0100
Jonathan Neuschäfer <j.neuschaefer@gmx.net> wrote:

> Currently, when kernel-doc encounters a macro with a named variable
> argument[1], such as this:
> 
>    #define hlist_for_each_entry_rcu(pos, head, member, cond...)
> 
> ... it expects the variable argument to be documented as `cond...`,
> rather than `cond`. This is semantically wrong, because the name (as
> used in the macro body) is actually `cond`.
> 
> With this patch, kernel-doc will accept the name without dots (`cond`
> in the example above) in doc comments, and warn if the name with dots
> (`cond...`) is used and verbose mode[2] is enabled.

This is a definite improvement, thanks.  Applied.

jon
