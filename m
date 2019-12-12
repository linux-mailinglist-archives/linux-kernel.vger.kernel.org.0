Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1173411D0F1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 16:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbfLLPZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 10:25:37 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43864 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728581AbfLLPZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:25:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576164336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g01sjYUUJQQDIxiuMqLLhsNe/mCACDYdL25mylQpAbw=;
        b=bhfvv1szIM20GOCc8ROWYkeUCnkl6mbZo6o9X3/+HvGkUTpsE6+upz3/yrcCd9TgB9oFOd
        tveh2ge0N25kQUDz59seDmiwwd1qw3z+dHr/u7MihaonLYczcsEVCRaZbkEt7QH8Zyqro8
        6pvjlBALw6Jt7nl365DGhuMtKhV+yII=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-0R81b4HTMX-nFTnPzZHP9w-1; Thu, 12 Dec 2019 10:25:34 -0500
X-MC-Unique: 0R81b4HTMX-nFTnPzZHP9w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4AEC107ACC7;
        Thu, 12 Dec 2019 15:25:32 +0000 (UTC)
Received: from rules.brq.redhat.com (unknown [10.43.2.123])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C14A95C21B;
        Thu, 12 Dec 2019 15:25:31 +0000 (UTC)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Input: fix USB alsetting bugs
Date:   Thu, 12 Dec 2019 16:25:18 +0100
Message-Id: <20191212152518.7117-1-vdronov@redhat.com>
In-Reply-To: <20191210113737.4016-1-johan@kernel.org>
References: <20191210113737.4016-1-johan@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 10.12.19 12:37, Johan Hovold wrote:

> We had quite a few driver using the first alternate setting instead of
> the current one when doing descriptor sanity checks. This is mostly an
> issue on kernels with panic_on_warn set due to a WARN() in
> usb_submit_urn(). Since we've started backporting such fixes (e.g. as
> reported by syzbot), I've marked these for stable as well.
>=20
> Included are also a couple of related clean ups to prevent future
> issues.

For the series:

Acked-by: Vladis Dronov <vdronov@redhat.com>

Best regards,
Vladis Dronov | Red Hat, Inc. | The Core Kernel | Senior Software Enginee=
r

