Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A48C917B0F2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 22:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgCEVvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 16:51:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:45598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbgCEVvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 16:51:53 -0500
Received: from [192.168.0.217] (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C281C20848;
        Thu,  5 Mar 2020 21:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583445113;
        bh=OBLxv2RC+hUsqt/a/fYH+EhVxf308CNV/rUKDAdPmQI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SUsFlYts/0m2/cLXlPdkV74vEPAqBwPI6hLanKwprhvrlJ31Hrj+lKrMWpzejSHYO
         DpxLpiESvp8BfBiJoFWssimW3GUYrcuBNHVSCibxo4jnSOe8cjut+69kB3K5UXIOU0
         X4AjgA/9JUtQmjTVt9+5iVlWdri5zRS8U/0WeoN0=
Subject: Re: [patch 15/16] x86/entry: Switch page fault exceptions to
 idtentry_simple
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20200225223321.231477305@linutronix.de>
 <20200225224145.657687951@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <afe4d10f-7976-5972-4152-fb641ed352bb@kernel.org>
Date:   Thu, 5 Mar 2020 13:51:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200225224145.657687951@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/20 2:33 PM, Thomas Gleixner wrote:
> Convert page fault exceptions to IDTENTRY_CR2:
>   - Implement the C entry point with DEFINE_IDTENTRY
>   - Emit the ASM stub with DECLARE_IDTENTRY
>   - Remove the ASM idtentry in 64bit
>   - Remove the CR2 read from 64bit
>   - Remove the open coded ASM entry code in 32bit
>   - Fixup the XEN/PV code
>   - Remove the old prototyoes

$SUBJECT says idtentry_simple.  I think you meant IDTENTRY_CR2.

(I typed this a while ago and apparently failed to hit send.  I'm not
sure it's still relevant.)
