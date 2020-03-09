Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C89517EC06
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 23:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgCIW1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 18:27:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbgCIW1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 18:27:38 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B235024649;
        Mon,  9 Mar 2020 22:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583792857;
        bh=SCrGQrtiQbHdndUvuWPRISRmR7N42dZ8DlMegyW5Wb0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=BACj3hfXpP29ednM4WvWuZsjYimfdeu/+LpcCFZUEi6sXMqZ0ACvFAVcUSp5EKgPY
         t7DWiIAgQ3EnGzN62zJOmAEkygGXIPFq3ybmIEuZ1xSfPY5aMm6ROPBf1QlfvbhRjY
         xcBY8ibee4+r8qYWlRYtvc4dR/F2+QggekF8a2fo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200228203611.15507-1-dinguyen@kernel.org>
References: <20200228203611.15507-1-dinguyen@kernel.org>
Subject: Re: [PATCH] clk: socfpga: stratix10: use new parent data scheme
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     dinguyen@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Dinh Nguyen <dinguyen@kernel.org>
Date:   Mon, 09 Mar 2020 15:27:36 -0700
Message-ID: <158379285687.149997.12928033376494434912@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dinh Nguyen (2020-02-28 12:36:11)
> +
> +static const struct clk_parent_data mpu_free_mux[] =3D {
> +       { .name =3D "main_mpu_base_clk", },
> +       { .name =3D "peri_mpu_base_clk", },
> +       { .name =3D "osc1", },
> +       { .name =3D "cb-intosc-hs-div2-clk", },
> +       { .name =3D "f2s-free-clk", },
> +};

While this changes everything to use the new way it doesn't actually
migrate anything over to using direct pointers or the .fw_name field.
What's going on?
