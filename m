Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E210178390
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 21:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731326AbgCCUBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 15:01:54 -0500
Received: from ms.lwn.net ([45.79.88.28]:38730 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730687AbgCCUBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 15:01:54 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4A107537;
        Tue,  3 Mar 2020 20:01:53 +0000 (UTC)
Date:   Tue, 3 Mar 2020 13:01:52 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Bird, Tim" <Tim.Bird@sony.com>
Cc:     "tbird20d@gmail.com" <tbird20d@gmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scripts/sphinx-pre-install: add '-p python3' to
 virtualenv
Message-ID: <20200303130152.461c3494@lwn.net>
In-Reply-To: <MWHPR13MB0895EFDA9EBF7740875E661CFDE40@MWHPR13MB0895.namprd13.prod.outlook.com>
References: <1582594481-23221-1-git-send-email-tim.bird@sony.com>
        <20200302130911.05a7e465@lwn.net>
        <MWHPR13MB0895EFDA9EBF7740875E661CFDE40@MWHPR13MB0895.namprd13.prod.outlook.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Mar 2020 17:07:48 +0000
"Bird, Tim" <Tim.Bird@sony.com> wrote:

> The less fragile approach would have been to just
> always add the '-p python3' option to the virtualenv setup hint,
> but Mauro seemed to want something more fine-tuned.

At some point I think we'll want to say that Python 2 just isn't supported
anymore.  After all, the language itself isn't supported anymore.  Perhaps
it's time to add a warning somewhere.

Thanks,

jon
