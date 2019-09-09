Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F75BAD4A4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2019 10:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388647AbfIIIRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 04:17:41 -0400
Received: from mxout017.mail.hostpoint.ch ([217.26.49.177]:64767 "EHLO
        mxout017.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726142AbfIIIRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 04:17:40 -0400
Received: from [10.0.2.45] (helo=asmtp012.mail.hostpoint.ch)
        by mxout017.mail.hostpoint.ch with esmtp (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i7Erc-0000a5-2X; Mon, 09 Sep 2019 10:17:32 +0200
Received: from [213.55.220.251] (helo=[100.66.103.90])
        by asmtp012.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i7Erb-0002xU-Sw; Mon, 09 Sep 2019 10:17:32 +0200
X-Authenticated-Sender-Id: sandro@volery.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Sandro Volery <sandro@volery.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] Fixed most indent issues in tty_io.c
Date:   Mon, 9 Sep 2019 10:17:30 +0200
Message-Id: <71E8E933-8F15-4B3E-9268-9FFAE2EEF618@volery.com>
References: <20190908205931.GG23683@mit.edu>
Cc:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20190908205931.GG23683@mit.edu>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
X-Mailer: iPhone Mail (17A5831c)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> strongly encouraged to restrict their checkpatch cleanups to the
> staging tree, since when such cleanup patches are considered welcome
> very much depends on the kernel subsystem and the maintainers
> involved.)

Should I still send the ones I tried to submit in this thread again
as separate patches? Since Greg said I should do it that way
so I'm not sure if I should do that quick or just stick to staging.

Thanks,
Sandro V.

