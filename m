Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8069E17E05
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 18:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfEHQWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 12:22:22 -0400
Received: from ms.lwn.net ([45.79.88.28]:53550 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbfEHQWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 12:22:20 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 02D482C5;
        Wed,  8 May 2019 16:22:19 +0000 (UTC)
Date:   Wed, 8 May 2019 10:22:19 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation/trace: Add clarification how histogram
 onmatch works
Message-ID: <20190508102219.30f8c625@lwn.net>
In-Reply-To: <20190508121854.2bf6340b@gandalf.local.home>
References: <20190507144946.7998-1-tstoyanov@vmware.com>
        <20190507201157.2673f2de@gandalf.local.home>
        <1557321326.2167.5.camel@kernel.org>
        <20190508121854.2bf6340b@gandalf.local.home>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 May 2019 12:18:54 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Jon,
> 
> Can you take this patch in your tree?

Will do.

jon
