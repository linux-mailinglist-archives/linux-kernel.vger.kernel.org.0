Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECB819755
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 06:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfEJEUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 00:20:33 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:7875 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725903AbfEJEUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 00:20:32 -0400
X-UUID: 6840245851e3448192aee4006048c008-20190510
X-UUID: 6840245851e3448192aee4006048c008-20190510
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 127925819; Fri, 10 May 2019 12:20:27 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 10 May 2019 12:20:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 10 May 2019 12:20:25 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <mhiramat@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <corbet@lwn.net>, <srv_heupstream@mediatek.com>,
        <yj.chiang@mediatek.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Subject: RE: [PATCH] Documentation: {u,k}probes: add tracing_on before tracing
Date:   Fri, 10 May 2019 12:19:49 +0800
Message-ID: <1557461989-29625-1-git-send-email-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <20190509220829.42cb21dc0555abe1de98df10@kernel.org>
References: <20190509220829.42cb21dc0555abe1de98df10@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 1CA06B267CE4478EE285A06EA3FFDD04B648AED898BFE11B98B3F8C4C573F0C12000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> From: Lecopzer Chen <lecopzer.chen@mediatek.com>
>> 
>> After following the document step by step, the `cat trace` can't be
>> worked without enabling tracing_on and might mislead newbies about
>> the functionality.

> OK, but isn't tracing_on enabled by default?

Yes, but it may be disabled by some distros' init process.


> Anyway, it looks good to me (for making sure the trace is enabled).

> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

> Thanks!

Thanks a lots for your reply!
