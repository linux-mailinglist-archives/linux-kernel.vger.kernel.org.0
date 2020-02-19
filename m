Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2EE1642F7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 12:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgBSLGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 06:06:37 -0500
Received: from ms.lwn.net ([45.79.88.28]:33892 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbgBSLGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 06:06:37 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D35222E5;
        Wed, 19 Feb 2020 11:06:35 +0000 (UTC)
Date:   Wed, 19 Feb 2020 04:06:29 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] Documentation: sort _SPHINXDIRS for 'make help'
Message-ID: <20200219040629.16648a09@lwn.net>
In-Reply-To: <f2f47689-6a59-1d5e-6eda-ee24fe2a8fc7@infradead.org>
References: <f2f47689-6a59-1d5e-6eda-ee24fe2a8fc7@infradead.org>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Feb 2020 23:26:06 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> Sort the _SPHINXDIRS so that the 'make help' output is easier to read &
> search and in a predictable order instead of some unknown pseudo-random
> order.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

But...that takes the challenge out of it!

Applied, thanks.

jon
