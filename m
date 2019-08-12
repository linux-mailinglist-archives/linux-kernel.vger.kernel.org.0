Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6DF8A913
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 23:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfHLVNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 17:13:52 -0400
Received: from ms.lwn.net ([45.79.88.28]:37092 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfHLVNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 17:13:52 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A05242D8;
        Mon, 12 Aug 2019 21:13:51 +0000 (UTC)
Date:   Mon, 12 Aug 2019 15:13:50 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Marco Villegas <git@marvil07.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: Fix typo on pull requests guide
Message-ID: <20190812151350.3280ee73@lwn.net>
In-Reply-To: <20190809232907.5432-1-git@marvil07.net>
References: <20190809232907.5432-1-git@marvil07.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Aug 2019 18:29:07 -0500
Marco Villegas <git@marvil07.net> wrote:

> Signed-off-by: Marco Villegas <git@marvil07.net>
> ---
>  Documentation/maintainer/pull-requests.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/maintainer/pull-requests.rst b/Documentation/maintainer/pull-requests.rst
> index 22b271de0304..1a2f99b67d25 100644
> --- a/Documentation/maintainer/pull-requests.rst
> +++ b/Documentation/maintainer/pull-requests.rst
> @@ -29,7 +29,7 @@ request to.
>  In order to create the pull request you must first tag the branch that you
>  have just created. It is recommended that you choose a meaningful tag name,
>  in a way that you and others can understand, even after some time.  A good
> -practice is to include in the name an indicator of the sybsystem of origin
> +practice is to include in the name an indicator of the subsystem of origin
>  and the target kernel version.

Applied, thanks.

jon
