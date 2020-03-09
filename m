Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C60917E82E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 20:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgCITUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 15:20:55 -0400
Received: from mail.efficios.com ([167.114.26.124]:56022 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgCITUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:20:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 93E64268957;
        Mon,  9 Mar 2020 15:20:54 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id DptTv-1axFZr; Mon,  9 Mar 2020 15:20:54 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 20E242687F2;
        Mon,  9 Mar 2020 15:20:54 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 20E242687F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1583781654;
        bh=L68X+yX7Dg61I4AlTGZRxYdbYo/6mwO0Yo91LUY8cMM=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=jZJn+QAzrA4Bs3MV9APVOi1KWOCNjrIikXsRQ2j3d/T1uHV90rWSOQt41/FQzNyWH
         NDgQ/dVqGbum8QERTRuYj/1i1S219AcTxhTrPHhtScOhHbpUCnvPdAAMoUIMwOxa76
         k4oiioh2tDlD5Rx2Ktwq5Clyn+YJpBu+YiJ7b8SfJ3pcjXLWTtTJL3nU9arxTk5r2G
         +Ypnl4PA64uRnPn7AAW8t0VofPxTC83a4TteV9dkIlhFFBwgrlLet4YsotHk8jObwe
         v1BJHG473B7NMbUovgNclTQacpfAekrWosV1A6ObKFAW0NryTeFmIZTMP1ezm+2qpe
         CrO/kcCHDZYog==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Bu6S9X57fdft; Mon,  9 Mar 2020 15:20:54 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 0FE51268870;
        Mon,  9 Mar 2020 15:20:54 -0400 (EDT)
Date:   Mon, 9 Mar 2020 15:20:53 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        paulmck <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        bristot <bristot@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <1780724191.21867.1583781653939.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200309150709.204bd306@gandalf.local.home>
References: <87mu8p797b.fsf@nanos.tec.linutronix.de> <20200309141546.5b574908@gandalf.local.home> <CAEXW_YQJ=vGxn5P=OtdkJT4NwE9+P0rAPEEQFdAUtyZ9Ck=qug@mail.gmail.com> <20200309150709.204bd306@gandalf.local.home>
Subject: Re: Instrumentation and RCU
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF73 (Linux)/8.8.15_GA_3895)
Thread-Topic: Instrumentation and RCU
Thread-Index: nmq9g+HpeGfsEN4s0H69X8PJAZNIiw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Mar 9, 2020, at 3:07 PM, rostedt rostedt@goodmis.org wrote:

> On Mon, 9 Mar 2020 11:42:28 -0700
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
>> Just started a vacation here and will be back on January 12th. Will
>> take a detailed look at Thomas's email at that time.
> 
> January 12th! Wow! Enjoy your sabbatical and see you next year! ;-)

If Joel can go through 10 months worth of email backlog, he is my hero. ;-)

On a side-note, I confirmed with Joel that he intends to come back on March 13th.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
