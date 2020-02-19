Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 037BE16427D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 11:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgBSKpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 05:45:31 -0500
Received: from ms.lwn.net ([45.79.88.28]:33756 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbgBSKpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 05:45:31 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5BF5C2DC;
        Wed, 19 Feb 2020 10:45:29 +0000 (UTC)
Date:   Wed, 19 Feb 2020 03:45:23 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] docs: sysctl/kernel.rst rework
Message-ID: <20200219034523.773492e6@lwn.net>
In-Reply-To: <20200218125923.685-1-steve@sk2.org>
References: <20200218125923.685-1-steve@sk2.org>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 13:59:15 +0100
Stephen Kitt <steve@sk2.org> wrote:

> A recent discussion about differences in the "panic" description in
> sysctl/kernel.rst led me to look into completing that file, and it
> turned out that more work was needed than documenting "panic". This
> patch series is the first batch, making the resulting documentation
> hopefully nicer and more accurate. It doesn't add fields that are
> present in 5.5 but not documented; I've started adding these, but I'd
> rather submit them individually once the basic kernel.rst is
> committed, to make it easier to request review from the appropriate
> maintainers (each patch adding documentation should be mergeable
> separately, without needing a patch series).

OK, I've applied everything except #7, which I commented on separately.

Thanks,

jon
