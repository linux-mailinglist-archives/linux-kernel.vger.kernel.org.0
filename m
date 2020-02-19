Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A09991637F6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 01:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbgBSAFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 19:05:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:49724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbgBSAFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 19:05:25 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64EB2208E4;
        Wed, 19 Feb 2020 00:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582070724;
        bh=sH5O3xWAIkvm8LQwxC8TtAEp/a7Uo9nlFDZX5BpE1BI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n34GwqorcOZe9+n/DJqkx+bN9uzQ3LmSN0iQe6xFjGjG2VrjWSeePqaDBPfsjHmBB
         XHc+QPAj7qb4SLqaMeTvJlpBRBwdVgQ7QZUHpfDDGMo9DZQN9aExDG7T8SEexciv+4
         8YzeJZIbJBUwKe8xctNcBGrU1/YzCHJNjjDs9QF0=
Date:   Wed, 19 Feb 2020 09:05:19 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Edmund Merrow-Smith <edmund@sucs.org>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] drivers: NVME: host: core.c: Fixed some coding style
 issues.
Message-ID: <20200219000519.GB18306@redsun51.ssa.fujisawa.hgst.com>
References: <20200218230131.12135-1-edmund@sucs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218230131.12135-1-edmund@sucs.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 11:01:31PM +0000, Edmund Merrow-Smith wrote:
> Fixed a number of style issues highlighted by scripts/checkpatch.pl.
> Mostly whitespace issues, implied int warnings,
> trailing semicolons and line length issues.

But checkpatch.pl is on the wrong side of the 'unsigned'/'unsigned int'
debate! The C standard defined unsigned since forever ago, its usage is
not at all confusing.
