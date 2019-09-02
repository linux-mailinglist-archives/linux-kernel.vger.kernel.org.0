Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 636E0A577C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 15:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbfIBNOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 09:14:30 -0400
Received: from ms.lwn.net ([45.79.88.28]:54944 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729672AbfIBNO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:14:29 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2F2C82D5;
        Mon,  2 Sep 2019 13:14:29 +0000 (UTC)
Date:   Mon, 2 Sep 2019 07:14:28 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Wu <peter@lekensteyn.nl>, Ingo Molnar <mingo@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v2] docs: ftrace: clarify when tracing is disabled by
 the trace file
Message-ID: <20190902071428.53526584@lwn.net>
In-Reply-To: <20190831115835.0a03b914@oasis.local.home>
References: <20190830175108.0ffa6ef1@gandalf.local.home>
        <20190831153500.7399-1-peter@lekensteyn.nl>
        <20190831115835.0a03b914@oasis.local.home>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Aug 2019 11:58:35 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Jon care to take this in your tree?

Will do.

jon
