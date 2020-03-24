Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A04F8191C8E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 23:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgCXWKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 18:10:53 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:60024 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727496AbgCXWKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 18:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585087852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ccclkoVXQpOw7927Ojoa/iW3BMVEU13+FLfEclrX90Q=;
        b=CmfnpnoQ0HlAflqrqb5kH3Oad2Ikt9QxwI/piE4i3zZgp08nMspmygzQ7TEMlFyvpU1ajN
        8yIUyl1TWs70gtM72ryeHKKKPxzdfznicIpCweTAVErWc1hJEAPDo1lf32GDzQb8K0rRBZ
        MFGXW/de1VD451JQWc5dCjL8Sa2+M8M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-Q7VuaSxdNNyTigAsq18s7g-1; Tue, 24 Mar 2020 18:10:48 -0400
X-MC-Unique: Q7VuaSxdNNyTigAsq18s7g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50B5D477;
        Tue, 24 Mar 2020 22:10:47 +0000 (UTC)
Received: from treble (unknown [10.10.119.253])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EE1565C1B2;
        Tue, 24 Mar 2020 22:10:45 +0000 (UTC)
Date:   Tue, 24 Mar 2020 17:10:43 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: Re: [PATCH v3 25/26] objtool: Rearrange validate_section()
Message-ID: <20200324221043.p4cwvgwlfgixosrv@treble>
References: <20200324153113.098167666@infradead.org>
 <20200324160925.410651737@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200324160925.410651737@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 04:31:38PM +0100, Peter Zijlstra wrote:
> In preparation of further changes, once again break out the loop body.
> No functional changes intended.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

