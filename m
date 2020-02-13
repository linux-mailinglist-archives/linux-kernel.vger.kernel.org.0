Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22BDA15CA94
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 19:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgBMSkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 13:40:15 -0500
Received: from ms.lwn.net ([45.79.88.28]:46952 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgBMSkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 13:40:15 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D91D92D8;
        Thu, 13 Feb 2020 18:40:14 +0000 (UTC)
Date:   Thu, 13 Feb 2020 11:40:13 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Wang Long <w@laoqinren.net>
Cc:     mchehab+samsung@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/ABI: move sysfs-kernel-uids to removed
 dirtory
Message-ID: <20200213114013.044a8b09@lwn.net>
In-Reply-To: <1581082930-30441-1-git-send-email-w@laoqinren.net>
References: <1581082930-30441-1-git-send-email-w@laoqinren.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Feb 2020 21:42:10 +0800
Wang Long <w@laoqinren.net> wrote:

> commit 7c9414385ebf ("sched: Remove USER_SCHED") delete the
> USER_SCHED feature. so move the ABI doc to removed dirtory.
> 
> Signed-off-by: Wang Long <w@laoqinren.net>

After ten years, we can probably do that, yes :)

Applied, thanks.

jon
