Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D86DB237E7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 15:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731054AbfETNQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 09:16:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729720AbfETNQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:16:14 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C04C20815;
        Mon, 20 May 2019 13:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558358174;
        bh=cuaMQudUn1mdzd7LPbf8KD1gkcV3y/02CAGXspfJd/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uiOMlbvwfRX5KHlajSqmAoxjBMm5GZWMhYXaGdMOgkoEeGhS+FaTvk4MjYlF4rzpw
         lWUNVND5cZaNI8ujcm1mbYD9eLrbHV7HHX5UFeLXn8EqFXGQpdIK6sSvx6taDrdU4W
         IB+QSFXDVkLHpkx6+kWjfgsKHSczMcny7BV3B/uQ=
Date:   Mon, 20 May 2019 16:16:10 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Michal Kalderon <michal.kalderon@marvell.com>, apw@canonical.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] checkpatch: add test for empty line after Fixes statement
Message-ID: <20190520131610.GK4573@mtr-leonro.mtl.com>
References: <20190520124238.10298-1-michal.kalderon@marvell.com>
 <ed26df86d7d0e12263404842895460b1611def61.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed26df86d7d0e12263404842895460b1611def61.camel@perches.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 05:56:36AM -0700, Joe Perches wrote:
> On Mon, 2019-05-20 at 15:42 +0300, Michal Kalderon wrote:
> > Check that there is no empty line after a fixes statement
>
> why?

It is common mistake for Gerrit users, they are removing
their ChangeID crap with some wrong sed command which leaves
empty line.

You can argue that this should be fixed on the client side and I agree,
nut because the checkpatch check is so easy, it is worth to add it and
save reviewers time.

Thanks

>
>
