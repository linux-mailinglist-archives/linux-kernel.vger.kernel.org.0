Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F71D645EA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 13:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfGJLsr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 10 Jul 2019 07:48:47 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:56004 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbfGJLsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 07:48:47 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id x6ABmWxS019986;
        Wed, 10 Jul 2019 12:48:33 +0100
Date:   Wed, 10 Jul 2019 12:48:32 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Martin =?UTF-8?B?SHVuZGViw7hsbA==?= <martin@geanix.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Sean =?UTF-8?B?Tnlla2o=?= =?UTF-8?B?w6Zy?= <sean@geanix.com>,
        Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCHv2 3/4] tty: n_gsm: add helper to convert mux-num to/from
 tty-base
Message-ID: <20190710124832.5a9a1daa@alans-desktop>
In-Reply-To: <20190709064633.45411-3-martin@geanix.com>
References: <20190709064633.45411-1-martin@geanix.com>
        <20190709064633.45411-3-martin@geanix.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  9 Jul 2019 08:46:32 +0200
Martin Hundebøll <martin@geanix.com> wrote:

> Make it obvious how the gsm mux number relates to the virtual tty lines
> by using helper function instead of shifting 6 bits.
> 
> Signed-off-by: Martin Hundebøll <martin@geanix.com>
> ---
>  drivers/tty/n_gsm.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index c4e16b31f9ab..cba06063c44a 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -2171,6 +2171,16 @@ static inline void mux_put(struct gsm_mux *gsm)
>  	kref_put(&gsm->ref, gsm_free_muxr);
>  }
>  
> +static inline int mux_num_to_base(struct gsm_mux *gsm)
> +{
> +	return gsm->num * NUM_DLCI;
> +}
> +
> +static inline unsigned int mux_line_to_num(int line)
> +{
> +	return line / NUM_DLCI;

If you are going to convert shifts to multiply and divide then used
unsigned maths so the compiler can optimize it nicely on some of the low
end processors.

Alan
