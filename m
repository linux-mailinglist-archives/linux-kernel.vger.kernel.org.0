Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30B1F10A8A8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 03:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfK0CPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 21:15:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:47100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbfK0CPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 21:15:33 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CB992071A;
        Wed, 27 Nov 2019 02:15:31 +0000 (UTC)
Date:   Tue, 26 Nov 2019 21:15:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     shuah <shuah@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUGFIX PATCH v4 2/4] selftests/ftrace: Fix ftrace test cases
 to check unsupported
Message-ID: <20191126211530.79a3d8f4@oasis.local.home>
In-Reply-To: <cc4c66dd-6f9d-6763-8172-02235e8e60ae@kernel.org>
References: <157475724667.3389.15752644047898709246.stgit@devnote2>
        <157475726452.3389.3778488615487716476.stgit@devnote2>
        <20191126124901.22ae2f9f@gandalf.local.home>
        <20191127083123.0257d2c450bfd87b0691300d@kernel.org>
        <cc4c66dd-6f9d-6763-8172-02235e8e60ae@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2019 16:50:54 -0700
shuah <shuah@kernel.org> wrote:

> No worries. Take your time. I won't pull in until things settle down.
> I noticed Steve gave you review comments.

Masami's last patch should be good to go.

Thanks Shuah,

-- Steve
