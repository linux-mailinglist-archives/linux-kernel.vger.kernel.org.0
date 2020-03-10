Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD24C180AFF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 22:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgCJV62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 17:58:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbgCJV62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 17:58:28 -0400
Received: from kicinski-fedora-PC1C0HJN (unknown [163.114.132.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FD4921927;
        Tue, 10 Mar 2020 21:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583877507;
        bh=PplOYQqEmWIiTN9MSGofr3Cpe2UGMzUlC3Gk0ty0kAs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vjUc4r/iYALDocXbYw7hovmUARxxENdgs3DvpnGSjlaTWz4uvQaqcAy/H9REhRY9i
         8kFoxG+HgXiYj52Uwo1xRE5isHdIy7x7Tiw3bxclGDHEwgw5uO+4KVC6eUp6lOdAtV
         aI6JleLE4M5zdp4uhhJYXYo5IA1sPGdCk14SQlsI=
Date:   Tue, 10 Mar 2020 14:58:25 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Alex Elder <elder@linaro.org>, David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] bitfield.h: add FIELD_MAX() and field_max()
Message-ID: <20200310145825.6ddb3797@kicinski-fedora-PC1C0HJN>
In-Reply-To: <20200310212938.GA17565@ubuntu-m2-xlarge-x86>
References: <20200306042302.17602-1-elder@linaro.org>
        <20200310212938.GA17565@ubuntu-m2-xlarge-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020 14:29:38 -0700 Nathan Chancellor wrote:
> Without this patch, the IPA driver that was picked up a couple of days
> ago does not build...

=F0=9F=98=B3=20

Yes please, Alex could you repost ASAP with [PATCH net-next] subject
and CC netdev to get it into the netdev patchwork?

Please also make IPA:

	depends on (ARCH_QCOM || COMPILE_TEST) && 64BIT && NET

Otherwise it's really hard to make sure the code builds.
