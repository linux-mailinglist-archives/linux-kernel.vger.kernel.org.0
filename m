Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCB61762F2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 19:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgCBSnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 13:43:01 -0500
Received: from ms.lwn.net ([45.79.88.28]:57964 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727362AbgCBSnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:43:01 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 19AE02E4;
        Mon,  2 Mar 2020 18:43:01 +0000 (UTC)
Date:   Mon, 2 Mar 2020 11:43:00 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Pragat Pandya <pragat.pandya@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: Re: [PATCH v2 0/2] Documentation: Add files to driver-api manual
Message-ID: <20200302114300.34875f69@lwn.net>
In-Reply-To: <20200302183105.27628-1-pragat.pandya@gmail.com>
References: <20200302104501.0f9987bb@lwn.net>
        <20200302183105.27628-1-pragat.pandya@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Mar 2020 00:01:03 +0530
Pragat Pandya <pragat.pandya@gmail.com> wrote:

> This patchset adds following two rst files under
> Documentation/driver-api and references these both in Sphinx TOC Tree in
> Documentation/driver-api/index.rst
>  -io-mapping.rst
>  -io_ordering.rst
> 
> v2: 
>  -Provide more descriptive subject lines
>  -The document did not belong to top level so moved it to driver-api
>   manual
> 
> Pragat Pandya (2):
>   Documentation: Add io-mapping.rst to driver-api manual
>   Documentation: Add io_ordering.rst to driver-api manual
> 
>  Documentation/driver-api/index.rst       |  2 +
>  Documentation/driver-api/io-mapping.rst  | 97 ++++++++++++++++++++++++
>  Documentation/driver-api/io_ordering.rst | 51 +++++++++++++
>  3 files changed, 150 insertions(+)
>  create mode 100644 Documentation/driver-api/io-mapping.rst
>  create mode 100644 Documentation/driver-api/io_ordering.rst

OK, we're getting closer.  This series, though, leaves the old files in
place.  You should rename them over, rather than simply creating new files.

Thanks,

jon
