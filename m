Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD8F6359F4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 11:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfFEJyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 05:54:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60524 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbfFEJyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 05:54:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4A76F85360;
        Wed,  5 Jun 2019 09:54:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA7832C8CA;
        Wed,  5 Jun 2019 09:53:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <21350864823e07cc951e1dc7f0601baa09920ac4.1559656538.git.mchehab+samsung@kernel.org>
References: <21350864823e07cc951e1dc7f0601baa09920ac4.1559656538.git.mchehab+samsung@kernel.org> <cover.1559656538.git.mchehab+samsung@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     dhowells@redhat.com,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        keyrings@vger.kernel.org
Subject: Re: [PATCH v2 15/22] docs: security: core.rst: Fix several warnings
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <26616.1559728436.1@warthog.procyon.org.uk>
Date:   Wed, 05 Jun 2019 10:53:56 +0100
Message-ID: <26617.1559728436@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 05 Jun 2019 09:54:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> +  *  ``asym_eds_op`` and ``asym_verify_signature``::
> +
> +       int (*asym_eds_op)(struct kernel_pkey_params *params,
> +			  const void *in, void *out);
> +       int (*asym_verify_signature)(struct kernel_pkey_params *params,
> +				    const void *in, const void *in2);

That's redundant and shouldn't be necessary.

David
