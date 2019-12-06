Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84C3F114ED1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2019 11:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfLFKNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Dec 2019 05:13:12 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29141 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726070AbfLFKNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 05:13:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575627191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VjFRH+KKy9lVo/LpjoVhiAMNpklSmLSTjCgJyK72eTk=;
        b=e1vNJNKvuZV/tVHTwCxSJiNMOGnRQYw1fzIrpdFIT05+HtDxoLuQJDXPzW1ydBlCEaO8OO
        xyOCoBQTmyffAf8mEC0/AF4cxfZNhQ8lwYLIOdf9HqZCWxi57iqkEMUgszvwX82Om/hY+j
        +C301YlQ+DHQRvT8uH+31J4cRzpeNCU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-_P5lLl6yMu6earcgehqAzw-1; Fri, 06 Dec 2019 05:13:09 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B89451005512;
        Fri,  6 Dec 2019 10:13:07 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com [10.36.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF2885D6A3;
        Fri,  6 Dec 2019 10:13:06 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 10F2416E18; Fri,  6 Dec 2019 11:13:06 +0100 (CET)
Date:   Fri, 6 Dec 2019 11:13:06 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/qxl: remove unnecessary BUG_ON check for handle
Message-ID: <20191206101306.rp2uxsmzgsshxey6@sirius.home.kraxel.org>
References: <20191205234231.10849-1-pakki001@umn.edu>
MIME-Version: 1.0
In-Reply-To: <20191205234231.10849-1-pakki001@umn.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: _P5lLl6yMu6earcgehqAzw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 05:42:31PM -0600, Aditya Pakki wrote:
> In qxl_gem_object_create_with_handle(), handle's memory is not
> allocated on the heap. Checking for failure of handle via BUG_ON
> is unnecessary. This patch eliminates the check.

The check makes sure the caller doesn't pass in handle =3D=3D NULL
and it is needed.

cheers,
  Gerd

