Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9EBF179D1A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 01:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgCEA6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 19:58:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:59050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgCEA6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 19:58:11 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A2CB20842;
        Thu,  5 Mar 2020 00:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583369890;
        bh=qBHd9zT00b7CN2peWKuf3SotoS9UgrnfGTi/urSOl9I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Oe/JVIOOL2NJ+2yNnt2zTB42B65tVfqHBaSFXBE2M3ztqk22pAO1uLMOIh7CQ2MKR
         dKmTVQKvvKoTOE6lu2tS6Kp0N1c8DyjO90n7CJUfgf0/BNzRFeB8b1o9y6VfhFFSji
         tEgsdcmztSbJ8nCVhFu2O1UAyBmoswbKimT4md/w=
Date:   Thu, 5 Mar 2020 09:58:06 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Markus Elfring <Markus.Elfring@web.de>, linux-doc@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [v4] Documentation: bootconfig: Update boot configuration
 documentation
Message-Id: <20200305095806.3ba477b939c07d5bec298b48@kernel.org>
In-Reply-To: <531371ef-354a-b0fa-f69f-c8cf9ecc9919@infradead.org>
References: <158322634266.31847.8245359938993378502.stgit@devnote2>
        <158322635301.31847.15011454479023637649.stgit@devnote2>
        <ad1e9855-4c64-53bd-7da5-f7cdafe78571@infradead.org>
        <20200304203722.8e8699c2a3e0a979aae091b1@kernel.org>
        <3a3a5f1a-3654-d96d-3b4a-dd649a366c65@web.de>
        <531371ef-354a-b0fa-f69f-c8cf9ecc9919@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Mar 2020 08:20:35 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 3/4/20 6:45 AM, Markus Elfring wrote:
> >> What about the following?
> >>
> >> User can group identical parent keys together and use braces to list child keys
> 
>    The user
> (as Markus noted)

OK.

> 
> >> under them.
> > 
> > Another wording alternative:
> > 
> > The user can group settings together. Curly brackets enclose a configuration then
> > according to a parent context.
> 
> I slightly prefer Masami's text.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
